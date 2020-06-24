//
//  RouteResponse.swift
//  GoodService
//
//  Created by Chris Sanders on 9/23/19.
//  Copyright © 2019 Chris Sanders. All rights reserved.
//

import Foundation

struct RouteMapsResponse: Codable {
    let routes: [String: Route]
    let stops: [String: Stop]
    
    struct Route: Codable {
        let id: String
        let name: String
        let color: String
        let destinations: [String: [String]]
        let routings: [String: [[String]]]
    }
    
    struct Stop: Codable {
        let id: String
        let name: String
        let trains: [Train]
    }
    
    struct Train: Codable {
        let id: String
        let name: String
        let color: String
    }
}
