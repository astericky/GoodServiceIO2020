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
    @StateObject private var routeInfoViewModel = RouteInfoViewModel()
    
    private var persistentController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            GoodServiceTabView(routeInfoViewModel: routeInfoViewModel)
                .environment(\.managedObjectContext, persistentController.container.viewContext)
        }
    }
}
