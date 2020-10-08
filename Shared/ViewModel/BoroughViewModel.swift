//
//  Borough.swift
//  iOS
//
//  Created by Chris Sanders on 6/23/20.
//

import Foundation

struct BoroughViewModel: Identifiable {
    var name: String
    var lines: LinesViewModel
    var id = UUID()
}

// Used to conform to the protocal Hashable with gives one the ability to
// differentiate between one item compared to another item
extension BoroughViewModel: Hashable {
    static func == (lhs: BoroughViewModel, rhs: BoroughViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
