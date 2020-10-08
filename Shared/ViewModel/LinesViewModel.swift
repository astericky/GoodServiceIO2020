//
//  LinesViewModel.swift
//  iOS
//
//  Created by Chris Sanders on 10/7/20.
//

import Foundation

struct LinesViewModel {

    var lineItems: [InfoResponse.Line]
    
    var lines: [LineViewModel] {
        lineItems.map(LineViewModel.init(item:))
    }
    
}
