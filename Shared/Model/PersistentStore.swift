//
//  PersistentStore.swift
//  iOS
//
//  Created by Chris Sanders on 7/25/20.
//

import SwiftUI
import CoreData

class PersistentStore: ObservableObject {
    
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    static let shared = PersistentStore()
    
    private init() {}
    
    private let persistentStoreName: String = "Favorites"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentStoreName)
        
//        guard let persistentStoreDescriptions = container.persistentStoreDescriptions.first else {
//            fatalError("\(#function): Failed to retrieve a persistent store description.")
//        }
        
//        persistentStoreDescriptions.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
//
//        persistentStoreDescriptions.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
//
//        container.viewContext.automaticallyMergesChangesFromParent = true
//        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        
        return container
    }()
    
    func save() {
        let context = persistentContainer.viewContext
        
//        if !context.commitEditing() {
//            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
//        }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
