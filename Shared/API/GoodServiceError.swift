//
//  InfoError.swift
//  GoodService
//
//  Created by Chris Sanders on 9/24/19.
//  Copyright © 2019 Chris Sanders. All rights reserved.
//

import Foundation

enum GoodServiceError: Error {
    case parsing(description: String)
    case network(description: String)
}
