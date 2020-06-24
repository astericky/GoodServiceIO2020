//
//  StatusResponse.swift
//  GoodService
//
//  Created by Chris Sanders on 9/24/19.
//  Copyright © 2019 Chris Sanders. All rights reserved.
//

import Foundation

struct StatusResponse: Codable {
    let timestamp: String
    let status: [String: RouteStatus]
    
    struct RouteStatus: Codable {
        let name: String
    }
}
