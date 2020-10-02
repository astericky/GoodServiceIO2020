//
//  ContentView.swift
//  Shared
//
//  Created by Chris Sanders on 6/22/20.
//

import SwiftUI

struct GoodServiceTabView: View {
    @ObservedObject var routeInfoViewModel: RouteInfoViewModel
    @State private var selection = 0
    
    var body: some View {
        ZStack {
            tabView
            if routeInfoViewModel.routes.isEmpty {
              loading
            }
        }
    }
}

extension GoodServiceTabView {
    var tabView: some View {
        TabView(selection: $selection) {
            routes
            lines
            slowZones
            favorites
        }
    }
    var routes: some View {
        RouteList(routeInfoVM: routeInfoViewModel)
            .tabItem {
                Image("subway")
                Text("Trains")
            }.tag(0)
    }
    
    var lines: some View {
        BoroughList(routeInfoViewModel: routeInfoViewModel)
            .tabItem {
                Image("railway")
                Text("Lines")
            }.tag(1)
    }
    
    var slowZones: some View {
        SlowZoneList(routeInfoViewModel: routeInfoViewModel)
            .tabItem {
                Image("problem")
                Text("Slow Zones")
            }.tag(2)
    }
    
    var favorites: some View {
        FavoritesList(routeInfoVM: routeInfoViewModel)
            .tabItem {
                Image(systemName: "star")
                Text("Favorites")
            }.tag(3)
    }
    
    var loading: some View {
        ProgressView()
    }
}

struct GoodServiceTabView_Previews: PreviewProvider {
    static var previewViewModel = RouteInfoViewModel()
    static var previews: some View {
        Group {
            GoodServiceTabView(routeInfoViewModel: previewViewModel)
//            GoodServiceTabView(routeInfoViewModel: previewViewModel)
//                .previewDevice("iPad Pro (9.7-inch)")
        }
    }
}
