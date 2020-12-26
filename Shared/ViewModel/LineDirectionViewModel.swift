//
//  LineDirection.swift
//  GoodService
//
//  Created by Chris Sanders on 10/12/19.
//  Copyright © 2019 Chris Sanders. All rights reserved.
//

import Foundation

struct LineDirectionViewModel {
    
    var direction: InfoResponse.Line.LineDirection
    
    var name: String {
        direction.name ?? ""
    }
    
    var maxActualWait: Int {
        direction.maxActualWait ?? 0
    }
    
    var maxScheduledWait: Int {
        direction.maxScheduledWait ?? 0
    }
    
    var trafficCondition: Double {
        direction.trafficCondition ?? 0
    }
    
    var delay: Int {
        direction.delay ?? 0
    }
    
    var routes: [LineRouteViewModel] {
        direction.routes.map(LineRouteViewModel.init(route:))
    }
}

// TODO: Need to conform to Hashable but this needs to be updated somehow
extension LineDirectionViewModel: Hashable {
    static func == (lhs: LineDirectionViewModel, rhs: LineDirectionViewModel) -> Bool {
        return lhs.delay == rhs.delay
            && lhs.maxActualWait == rhs.maxActualWait
            && lhs.maxScheduledWait == rhs.maxScheduledWait
            && lhs.trafficCondition ==  rhs.trafficCondition
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.delay)
    }
}
