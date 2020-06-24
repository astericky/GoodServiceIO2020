//
//  LineDirection.swift
//  GoodService
//
//  Created by Chris Sanders on 10/12/19.
//  Copyright © 2019 Chris Sanders. All rights reserved.
//

import Foundation

struct LineDirection {
    
    var item: InfoResponse.Line.LineDirection
    
    var maxActualWait: Int {
        item.maxActualWait ?? 0
    }
    
    var maxScheduledWait: Int {
        item.maxScheduledWait ?? 0
    }
    
    var trafficCondition: Double {
        item.trafficCondition ?? 0
    }
    
    var delay: Int {
        item.delay ?? 0
    }
}

// TODO: Need to conform to Hashable but this needs to be updated somehow
extension LineDirection: Hashable {
    static func == (lhs: LineDirection, rhs: LineDirection) -> Bool {
        return lhs.delay == rhs.delay
            && lhs.maxActualWait == rhs.maxActualWait
            && lhs.maxScheduledWait == rhs.maxScheduledWait
            && lhs.trafficCondition ==  rhs.trafficCondition
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.delay)
    }
}
