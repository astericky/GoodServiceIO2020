//
//  TestData.swift
//  GoodServiceIO
//
//  Created by Chris Sanders on 6/6/19.
//  Copyright © 2019 Chris Sanders. All rights reserved.
//

import Foundation

let routesInfo: InfoResponse = load("info.json")
let statsInfo: StatusResponse = load("stats.json")
let routeMapInfo: RouteMapsResponse = load("route-map.json")

var lines: [Line] = {
    routesInfo.lines["Manhattan"]!.map { item in
        let routesTestData = routesInfo.routes.filter { $0.id == item.id }
        let routesData = routesTestData.map { Route(item: $0) }
        return Line(item: item, routes: routesData)
    }
}()


func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
