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
    @Published var routes: [RouteViewModel] = []
    @Published var boroughs: [BoroughViewModel] = []
    @Published var slowZones: [LineViewModel] = []
    @Published var datetime: String = ""

    private var goodServiceFetcher = GoodServiceFetcher()
    private var subscriptions = Set<AnyCancellable>()
 

    init() {
//        self.fetchRouteMap()
        self.fetchRouteInfo()
    }
    
    
    func fetchRouteMap() {
        goodServiceFetcher.getRouteMaps()
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
                    self.routeMaps = value
                })
            .store(in: &subscriptions)
            
    }
    
    func fetchRouteInfo() {
        goodServiceFetcher.getInfo()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] info in
                    guard let self = self else { return }
                    self.datetime = {
                        let isoDate = info.timestamp
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MMM dd, yyyy h:mm a"
                        if let date = dateFormatter.date(from: isoDate) {
                            return dateFormatter.string(from: date)
                        }
                        return "Date unknown."
                    }()
                    self.routes = info.routes.map(RouteViewModel.init(item:))
                    print(self.routes.count)
                    self.boroughs = info.lines.map { boroughs in
                        BoroughViewModel(name: boroughs.key,
                                         lines: LinesViewModel(lineItems: boroughs.value))
                    }
                    
                    self.slowZones = self.getSlowLines()
                })
            .store(in: &subscriptions)
    }
    
    private func reset() {
        self.datetime = ""
        self.routes = []
        self.boroughs = []
        self.slowZones = []
    }
    
    private func getSlowLines() -> [LineViewModel] {
        let linesVMArray = self.boroughs.compactMap({
            $0.lines
        })
        
        let lines = linesVMArray.map { linesVM -> [LineViewModel] in
            var linesArray = linesVM.lines
            linesArray.sort { $0.maxTravelTime > $1.maxTravelTime }
            return linesArray
        }[0]
        
        return Array(lines.prefix(10))
    }
    
    
}
