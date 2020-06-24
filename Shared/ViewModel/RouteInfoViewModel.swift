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
    
    @Published var routes: [Route] = []
    @Published var boroughs: [Borough] = []
    @Published var slowZones: [Line] = []
    
    private var goodServiceFetcher = GoodServiceFetcher()
    private var disposables = Set<AnyCancellable>()
    
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
                  let routes = self.routes.filter { $0.id == line.id }
                  return Line(item: line, routes: routes)
              }
              return Borough.init(name: boroughs.key, lines: lines)
            }
            self.slowZones = self.getSlowLines()
        #else
            self.fetchRouteInfo()
        #endif
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
                    let routes = self.routes.filter { $0.id == line.id }
                    return Line(item: line, routes: routes)
                }
                return Borough.init(name: boroughs.key, lines: lines)
              }
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
