//
//  DatabaseManager.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/24/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import UIKit
import CoreData

protocol DatabaseDAO {
    func saveContext() -> Bool
}

class DatabaseDAOImpl: DatabaseDAO {
    private let modelName: String = "MoneyLover"
    static let shared = DatabaseDAOImpl()
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel? = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            return nil
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            return nil
        }
        
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel!)
        
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        
        var documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0] // can save in Library
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            // Add Persistent Store: Adding a persistent store can fail
            let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: options)
        } catch {
            
        }
        
        return persistentStoreCoordinator
    }()
    
    func saveContext() -> Bool {
        if !managedObjectContext.hasChanges {
            return true
        }
        do {
            try managedObjectContext.save()
            return true
            
        } catch let error as NSError {
            debugPrint("Unresolved error \(error), \(error.userInfo)")
            managedObjectContext.rollback()
            return false
        }
    }
}
