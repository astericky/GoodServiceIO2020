//
//  FavoriteButton.swift
//  iOS
//
//  Created by Chris Sanders on 7/31/20.
//

import SwiftUI

struct FavoriteButton: View {
    
    var route: RouteViewModel
    
    @Environment(\.managedObjectContext) var moc

    @FetchRequest<Favorite> var fetchRequest: FetchedResults<Favorite>
    
    var favorite: Favorite? {
        fetchRequest.first
    }

    @State var isFavorite = false
    
    init(route: RouteViewModel) {
        self.route = route
        _fetchRequest = Favorite.fetchFavorite(route: route)
    }
    
    
    var body: some View {
        Image(systemName: isFavorite ? "star.fill" : "star")
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor((isFavorite ? .yellow : .gray))
            .onTapGesture(count: 1, perform: toggleFavorite)
            .onAppear{ isFavorite = favorite != nil }
    }
    
    func toggleFavorite() {
        if let favorite = favorite {
            Favorite.remove(favorite: favorite, using: moc)
            isFavorite = false
        } else {
            Favorite.createFavorite(route: route, using: moc)
            isFavorite = true
        }
    }
}

#if DEBUG
struct FavoriteButton_Previews: PreviewProvider {
    static var route = RouteViewModel(item: routesInfo.routes[0])
    static var previews: some View {
        FavoriteButton(route: route)
    }
}
#endif
