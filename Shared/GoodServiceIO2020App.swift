//
//  GoodServiceIO2020App.swift
//  Shared
//
//  Created by Chris Sanders on 6/22/20.
//

import SwiftUI
import CoreData

@main
struct GoodServiceIO2020App: App {
    @StateObject private var routeInfoViewModel = RouteInfoViewModel()
    
    var body: some Scene {
        WindowGroup {
            GoodServiceTabView(routeInfoViewModel: routeInfoViewModel)
        }
    }
}
