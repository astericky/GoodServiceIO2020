//
//  LineRouteViewModel.swift
//  iOS
//
//  Created by Chris Sanders on 10/7/20.
//

import SwiftUI

struct LineRouteViewModel {
    var route: InfoResponse.Line.Route
    
    var id: String {
        route.id
    }
    
    var name: String {
        route.name
    }
    
    var color: Color {
        Color.createColor(from: route.color)
    }
}

// Used to conform to the protocal Hashable with gives one the ability to
// differentiate between one item compared to another item
extension LineRouteViewModel: Hashable {
    static func == (lhs: LineRouteViewModel, rhs: LineRouteViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
