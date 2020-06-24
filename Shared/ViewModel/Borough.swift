//
//  Borough.swift
//  iOS
//
//  Created by Chris Sanders on 6/23/20.
//

import Foundation

struct Borough: Identifiable {
    var name: String
    var lines: [Line]
    var id = UUID()
}

// Used to conform to the protocal Hashable with gives one the ability to
// differentiate between one item compared to another item
extension Borough: Hashable {
    static func == (lhs: Borough, rhs: Borough) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
