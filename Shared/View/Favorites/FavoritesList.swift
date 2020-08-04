//
//  FavoritesList.swift
//  iOS
//
//  Created by Chris Sanders on 7/24/20.
//

import SwiftUI

struct FavoritesList: View {
    
    @ObservedObject var routeInfoViewModel: RouteInfoViewModel
    
    @FetchRequest(
      entity: Favorites.entity(),
      sortDescriptors: [
        NSSortDescriptor(keyPath: \Favorites.title, ascending: true)
      ]
    ) var favorites: FetchedResults<Favorites>

    var body: some View {
        VStack {
            NavigationView {
                List(content: content)
                    .listStyle(InsetGroupedListStyle())
                    .navigationBarTitle(Text("Favorites"))
            }
        }
    }
}

extension FavoritesList {
    private func content() -> some View {
        Group {
            ForEach(favorites) { favorite in
                let route = routeInfoViewModel.routes.filter { $0.name == favorite.title }[0]
                FavoriteRow(favorite: favorite, route: route)
            }
        }
    }
    
    private func selectView(for route: Route) -> some View {
        if route.status == "No Service"
            || route.status == "Not Scheduled" {
            return AnyView(RouteNoServiceRow(route: route))
        } else {
            return AnyView(
                RouteRow(route: route)
                    .padding(0)
            )
        }
    }
}

//struct FavoritesList_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesList()
//    }
//}
