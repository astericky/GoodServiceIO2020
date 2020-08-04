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
    @Environment (\.scenePhase) private var scenePhase
    @StateObject private var persistentStore = PersistentStore.shared
    
    @StateObject private var routeInfoViewModel = RouteInfoViewModel()
    @StateObject private var routeMapStore = RouteMapsStore()
    
    var body: some Scene {
        WindowGroup {
            GoodServiceTabView(routeInfoViewModel: routeInfoViewModel)
                .environmentObject(routeMapStore)
                .environment(\.managedObjectContext, persistentStore.context)
        }
    }
}
