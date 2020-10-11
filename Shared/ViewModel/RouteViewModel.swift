//
//  RoutesRowViewModel.swift
//  GoodService
//
//  Created by Chris Sanders on 9/26/19.
//  Copyright © 2019 Chris Sanders. All rights reserved.
//

import SwiftUI

struct RouteViewModel: Identifiable {
    var item: InfoResponse.Route
    
    var id: String {
        return item.id
    }
    
    var name: String {
        return item.name
    }
    
    var alternateName: String {
        return item.alternateName ?? ""
    }
    
    var color: Color {
        Color.createColor(from: item.color ?? "")
    }
    
    var colorHex: String {
        item.color ?? ""
    }
    
    var statusColor: Color {
        switch self.item.status {
        case "Good Service":
            return Color("color-good-service")
        case "Not Good":
            return Color("color-not-good-service")
        case "Service Change":
            return Color("color-service-change")
        case "Delay":
            return Color("color-delayed-service")
        case "Not Scheduled":
            fallthrough
        default:
            return Color("color-no-service")
        }
    }
    
    var status: String {
        return item.status
    }
    
    var northDestination: RouteDestination? {
        guard let north = item.destinations.north, north.count > 0 else {
            return nil
        }
        let name = north.joined(separator: " ,")
        let directions = item.north.map { RouteDirection(item: $0) }
        return RouteDestination(name: name, directions: directions)
    }
    
    var southDestination: RouteDestination? {
        guard let south = item.destinations.south, south.count > 0 else {
            return nil
        }
        let name = south.joined(separator: " ,")
        let directions = item.south.map { RouteDirection(item: $0) }
        return RouteDestination(name: name, directions: directions)
    }
}

// Used to conform to the protocal Hashable with gives one the ability to
// differentiate between one item compared to another item
extension RouteViewModel: Hashable {
    static func == (lhs: RouteViewModel, rhs: RouteViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
    }
}
