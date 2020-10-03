//
//  Line.swift
//  GoodService
//
//  Created by Chris Sanders on 9/26/19.
//  Copyright © 2019 Chris Sanders. All rights reserved.
//

import SwiftUI

struct Line: Identifiable {
    var item: InfoResponse.Line
    var routes: [Route]
    
     var id: String {
        return item.id
    }
    
    var name: String {
        return item.name
    }
    
    var destinations: InfoResponse.Line.Destination {
        item.destinations
    }
    
    var north: [InfoResponse.Line.LineDirection] {
        return item.north
    }
    
    var south: [InfoResponse.Line.LineDirection] {
        return item.south
    }
    
    var maxTravelTime: Double {
        item.maxTravelTime
    }
    
    var status: String {
        item.status
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
}

// Used to conform to the protocal Hashable with gives one the ability to
// differentiate between one item compared to another item
extension Line: Hashable {
    static func == (lhs: Line, rhs: Line) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
