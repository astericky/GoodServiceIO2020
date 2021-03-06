//
//  Persistence.swift
//  iOS
//
//  Created by Chris Sanders on 9/21/20.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Favorites")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    // MARK: - CRUD Operations
//    func getAllFavorites() -> [Favorite] {
//        var favorites = [Favorite]()
//        
//        let request: NSFetchRequest<Favorite> = FavoriteItem.fetchRequest()
//        
//        do {
//            favorites = try self.container.viewContext.fetch(request)
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//        
//        return favorites
//    }
    
//    func create(favorite route: Route) throws {
//        let newFavorite = Favorite(context: container.viewContext)
//        newFavorite.id = UUID()
//        newFavorite.title = route.name
//        newFavorite.subtitle = route.alternateName
//        newFavorite.color = route.colorHex
//        newFavorite.status = route.status
//        
//        self.container.viewContext.insert(newFavorite)
//        
//        try save()
//    }
//    
//    private func save() throws {
//        do {
//            try container.viewContext.save()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//    
//    func deleteFavorite(favorite route: Route) throws {
//        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
//        request.predicate = NSPredicate(format: "title = %@", route.name)
//        
//        let results = try container.viewContext.fetch(request)
//        if let result = results.first {
//            container.viewContext.delete(result)
//        }
//    }
}
