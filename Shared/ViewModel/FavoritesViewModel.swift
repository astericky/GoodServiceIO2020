//
//  FavoritesViewModel.swift
//  iOS
//
//  Created by Chris Sanders on 9/21/20.
//

import CoreData
import SwiftUI
import Combine

class FavoritesViewModel: ObservableObject {
    
    @Published var favorites = [FavoriteViewModel]()
    private var context = PersistenceController.shared.container.viewContext
    
    
    func fetchAllFavorites() -> FetchRequest<Favorite> {
//        DispatchQueue.main.async {
//            self.favorites = PersistenceController.shared.getAllFavorites().map(FavoriteViewModel.init)
//        }
        FetchRequest(entity: Favorite.entity(), sortDescriptors: [])
    }
    
//    func saveFavorite(route: Route) {
//        do {
//            try PersistenceController.shared.create(favorite: route)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    func removeFavorite(route: Route) {
//        do {
//            try PersistenceController.shared.deleteFavorite(favorite: route)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
}


class FavoriteViewModel: Identifiable {
    
    var favorite: Favorite
    
    init(favorite: Favorite) {
        self.favorite = favorite
    }
    
    var id: String {
        favorite.id.uuidString
    }
    
    var title: String {
        favorite.title
    }
    
    var color: Color {
        Color.createColor(from: favorite.color)
    }
    
    var subtitle: String {
        favorite.subtitle
    }
    
    var status: String {
        favorite.status
    }
    
}
