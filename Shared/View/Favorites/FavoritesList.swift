//
//  FavoritesList.swift
//  iOS
//
//  Created by Chris Sanders on 7/24/20.
//

import SwiftUI

struct FavoritesList: View {
    
    @ObservedObject var routeInfoVM: RouteInfoViewModel
    let fetchRequest = Favorite.fetchAllFavorites()

    var favorites: FetchedResults<Favorite> {
        fetchRequest.wrappedValue
    }

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
            ForEach(favorites, id: \.self) { favorite -> AnyView in
                let route = routeInfoVM.routes.filter {
                    $0.name == favorite.title && ($0.alternateName) == favorite.subtitle
                }[0]
                return self.selectView(for: route)
            }
        }
    }
    
    private func selectView(for route: Route) -> AnyView {
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
