//
//  Favorite+CoreDataProperties.swift
//  iOS
//
//  Created by Chris Sanders on 9/30/20.
//

import CoreData
import SwiftUI


extension Favorite {
    @NSManaged var id: UUID
    @NSManaged var title: String
    @NSManaged var subtitle: String
    @NSManaged var type: String
    @NSManaged var status: String
    @NSManaged var color: String
    
    static func createFavorite(route: Route,
                               using viewContext: NSManagedObjectContext) {
        let favorite = Favorite(context: viewContext)
        favorite.id = UUID()
        favorite.title = route.name
        favorite.subtitle = route.alternateName
        favorite.color = route.colorHex
        favorite.status = route.status
        save(using: viewContext)
    }
    
    static func fetchAllFavorites() -> FetchRequest<Favorite> {
        FetchRequest(entity: Favorite.entity(), sortDescriptors: [])
    }
    
    static func fetchFavorite(route: Route) -> FetchRequest<Favorite> {
        let titlePredicate = NSPredicate(format: "title = %@", route.name)
        let subtitlePredicate = NSPredicate(format: "subtitle = %@", route.alternateName)
        let subPredicate = [titlePredicate, subtitlePredicate]
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: subPredicate)
        return FetchRequest(entity: Favorite.entity(),
                            sortDescriptors: [],
                            predicate: compoundPredicate)
    }
    
    static func remove(favorite: Favorite,
                       using viewContext: NSManagedObjectContext) {
        viewContext.delete(favorite)
        print(favorite.subtitle)
        save(using: viewContext)
    }
    
    static func save(using viewContext: NSManagedObjectContext) {
        do {
            try viewContext.save()
        } catch {
            fatalError("Unresolved error \(error), \(error.localizedDescription)")
        }
    }
}
