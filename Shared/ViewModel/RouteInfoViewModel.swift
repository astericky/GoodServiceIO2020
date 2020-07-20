//
//  InfoViewModel.swift
//  iOS
//
//  Created by Chris Sanders on 6/22/20.
//
import CoreData
import Combine
import SwiftUI

final class RouteInfoViewModel: ObservableObject {
    @Published var routeMaps: RouteMapsResponse = RouteMapsResponse(
        routes: [String : RouteMapsResponse.Route](),
        stops: [String : RouteMapsResponse.Stop]()
    )
    
    var stationDetails: [String: Any]?
    
    @Published var routes: [Route] = []
    @Published var boroughs: [Borough] = []
    @Published var slowZones: [Line] = []
    
    private var goodServiceFetcher = GoodServiceFetcher()
    private var disposables = Set<AnyCancellable>()
    private var routeMapCancellable: AnyCancellable?
    private var stationDetailsCancellable: AnyCancellable?
    
    private var timestamp = ""
    var datetime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.init(abbreviation: "EST")
        let date = dateFormatter.date(from: timestamp)
        let dateDisplayFomatter = DateFormatter()
        dateDisplayFomatter.dateFormat = "MMM dd, yyyy h:mm a"
        
        return dateDisplayFomatter.string(from: date ?? Date())
    }
    
    init() {
        #if DEBUG
        self.timestamp = routesInfo.timestamp
        self.routes = routesInfo.routes.map(Route.init(item:))
        self.boroughs = routesInfo.lines.map { boroughs in
            let lines = boroughs.value.map { line -> Line in
                let lineRoutes = line.routes.flatMap { route in
                    return self.routes.filter {
                        return $0.id == route.id
                    }
                }
                return Line(item: line, routes: lineRoutes)
            }
            return Borough.init(name: boroughs.key, lines: lines)
        }

        self.slowZones = self.getSlowLines()
        #else
        self.fetchRouteMap() {
            self.fetchRouteInfo()
        }
        
        #endif
    }
    
//    init() {
//        self.fetchStationDetails() {
//            #if DEBUG
//            self.timestamp = routesInfo.timestamp
//            self.routes = routesInfo.routes.map(Route.init(item:))
//            self.boroughs = routesInfo.lines.map { boroughs in
//                let lines = boroughs.value.map { line -> Line in
//                    let lineRoutes = line.routes.flatMap { route in
//                        return self.routes.filter {
//                            return $0.id == route.id
//                        }
//                    }
//                    return Line(item: line, routes: lineRoutes)
//                }
//                return Borough.init(name: boroughs.key, lines: lines)
//            }
//
//            self.slowZones = self.getSlowLines()
//            #else
//            self.fetchRouteMap() {
//                self.fetchRouteInfo()
//            }
//            #endif
//        }
//
//    }
    
    func fetchStationDetails(completion: @escaping () -> Void) {
        stationDetailsCancellable = goodServiceFetcher.getStationDetails()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { value in
                    switch value {
                    case .failure:
                        fatalError("Getting station details failed.")
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] value in
                    guard let self = self else { return }
                    self.stationDetails = value
                    print("stationDetails :: \(String(describing: self.stationDetails))")
                    completion()
                })
    }
    
    func fetchRouteMap(completion: @escaping () -> Void) {
        routeMapCancellable = goodServiceFetcher.getRouteMaps()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.reset()
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] value in
                    guard let self = self else { return }
                    self.routeMaps = RouteMapsResponse(routes: value.routes, stops: value.stops)
                    completion()
                })
            
    }
    
    
    
    func fetchRouteInfo() {
        goodServiceFetcher.getInfo()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.reset()
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] info in
                    guard let self = self else { return }
                    self.timestamp = info.timestamp
                    self.routes = info.routes.map(Route.init(item:))
                    self.boroughs = info.lines.map { boroughs in
                        let lines = boroughs.value.map { line -> Line in
                            let lineRoutes = line.routes.flatMap { route in
                                return self.routes.filter {
                                    return $0.id == route.id
                                }
                            }
                            return Line(item: line, routes: lineRoutes)
                        }
                        return Borough.init(name: boroughs.key, lines: lines)
                    }
                    
                    // TODO: add train route coordinates
                    self.routes = self.routes.map { item in
                        var route = item
                        
                        // 1. grab the list of stations routings north
                        let northRoutingsData = self.routeMaps.routes[route.id]?.routings["north"] ?? []
                        let southRoutingsData = self.routeMaps.routes[route.id]?.routings["south"] ?? []
                        
                        // 2. remove the last item from routings north
                        let northRoutingList = northRoutingsData.map { routingsDataItems -> [String] in
                            routingsDataItems.map { routingsDataItem in
                                var newItem = routingsDataItem
                                newItem.removeLast()
                                return newItem
                            }
                        }
                        let southRoutingList = southRoutingsData.map { routingsDataItems -> [String] in
                            routingsDataItems.map { routingsDataItem in
                                var newItem = routingsDataItem
                                newItem.removeLast()
                                return newItem
                            }
                        }
                        route.northRouteList = northRoutingList
                        route.southRouteList = southRoutingList
                        
                        // 3. match each routings north station to routeMap key
                        let coordinates = route.northRouteList?[0].enumerated().map { (index, stationID) -> [CLLocationCoordinate2D] in
                            if let station = self.stationDetails?[stationID] as? [String: Any],
                               let nextStation = self.stationDetails?[route.northRouteList![0][index + 1]] as? [String: Any] {
                                let initialCoordinate = CLLocationCoordinate2D(
                                    latitude: CLLocationDegrees(station["latitude"] as! Double),
                                    longitude: CLLocationDegrees(station["longitude"] as! Double)
                                )
                                if var stationNorth = station["north"] as? [String: Any],
                                   !stationNorth.isEmpty {
                        
                                    
                                    
                                }
                            }
                            
                            return []
                        }
                        
                        
                        return route
                    }
                    
                    
                    // 4. loop through and create coordinates
                    
                    self.slowZones = self.getSlowLines()
                    
                })
            .store(in: &disposables)
    }
    
    private func reset() {
        self.timestamp = ""
        self.routes = []
        self.boroughs = []
        self.slowZones = []
    }
    
    private func getSlowLines() -> [Line] {
        var lines = self.boroughs.flatMap({
            $0.lines
        })
        
        lines.sort { $0.maxTravelTime > $1.maxTravelTime }
        return Array(lines.prefix(10))
    }
    
    
}
