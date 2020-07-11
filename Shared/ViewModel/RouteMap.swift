//
//  RouteMap.swift
//  iOS
//
//  Created by Chris Sanders on 6/30/20.
//

import Foundation

//struct RouteMapJSON: Codable {
//    let routes: [String: RouteMapJSON.Route]
//
//    struct Route: Codable {
//        let id: String
//        let name: String
//        let color: String
//        let alternate_name: String
//        let routings: RouteMapJSON.Routing
//
//        enum CodingKeys: String, CodingKey {
//            case id
//            case name
//            case color
//            case alternate_name
//            case routings
//        }
//    }
//
//    struct Routing: Codable {
//        let north: [[String]]
//        let south: [[String]]
//
//        enum CodingKeys: String, CodingKey {
//            case north
//            case south
//        }
//    }
//}

class RouteMap: ObservableObject {
    var name: String
//    var routeData: RouteMapJSON.Route {
//        Bundle.main.decode(RouteMapJSON.self, from: "route-map.json").routes["name"]
//    }
    init(name: String) {
        self.name = name
    }
    
    func getRouteNumbers() -> [StationDetails] {
        var stations = [StationDetails]()
//        print(Bundle.main.decode(RouteMapJSON, from: "route-map.json"))
        return stations
    }
}
