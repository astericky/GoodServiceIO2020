//
//  FavoriteButton.swift
//  iOS
//
//  Created by Chris Sanders on 7/31/20.
//

import SwiftUI

struct FavoriteButton: View {
    
    let route: Route
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Favorites.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Favorites.title, ascending: true)
        ]
    ) var favorites: FetchedResults<Favorites>
    
    private var isFavorite: Bool {
        favorites.contains(where: { $0.title == route.id })
    }
    
    var body: some View {
        Image(systemName: self.isFavorite ? "star.fill" : "star")
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor((self.isFavorite ? .yellow : .gray))
            .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: toggleFavorite)
    }
    
    func toggleFavorite() {
        // TODO: Add check if it is already a favorite
        // if it is remove it from favorites
        // if it is not a favorite add it to favorites
        if self.isFavorite {
            let favoriteIndex = self.favorites.firstIndex(where: { $0.title == self.route.name })
            if let hasFavoriteIndex = favoriteIndex {
                let favorite = self.favorites[hasFavoriteIndex]
                
                self.moc.delete(favorite)
                
                try? self.moc.save()
            }
        } else {
            let newFavorite = Favorites(context: self.moc)
            newFavorite.id = UUID()
            newFavorite.title = self.route.name
            newFavorite.subtitle = self.route.alternateName
            newFavorite.color = self.route.colorHex
            newFavorite.status  = self.route.status
            
            try? self.moc.save()
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var route = Route(item: routesInfo.routes[0])
    static var previews: some View {
        FavoriteButton(route: route)
    }
}
