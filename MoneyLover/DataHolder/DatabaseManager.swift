//
//  DatabaseManager.swift
//  MoneyLover
//
//  Created by Hoang Anh Tuan on 5/24/20.
//  Copyright © 2020 Hoang Anh Tuan. All rights reserved.
//

import UIKit
import CoreData

enum Type: Int {
    case expenses = 1
    case revenue
    case loan
}

protocol DatabaseDAO {
    func saveContext() -> Bool
}

class DatabaseManager: DatabaseDAO {
    private let modelName: String = "MoneyLover"
    static let shared = DatabaseManager()
    
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
    
    // Category
    func newCategory(id: Int16, name: String, imageName: String, type: Int16) -> Category {
        let category = Category(context: managedObjectContext)
        category.id = id
        category.name = name
        category.imageName = imageName
        category.type = type
        return category
    }
    
    func getListDefaultCategory() -> [Category] {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Category.id), ascending: true)]
        var categories: [Category] = []
        
        managedObjectContext.performAndWait {
            do {
                categories = try fetchRequest.execute()
                if categories.isEmpty {
                    initializeListDefaultCategory()
                    categories = getListDefaultCategory()
                }
            } catch let error {
                print("Can not fetch list category: \(error)")
            }
        }
        return categories
    }
    
    func initializeListDefaultCategory() {
        let _ = newCategory(id: 1, name: "Appointments", imageName: "Appointments", type: 0)
        let _ = newCategory(id: 2, name: "Birthdays", imageName: "Birthdays", type: 1)
        let _ = newCategory(id: 3, name: "Chores", imageName: "Chores", type: 2)
        let _ = newCategory(id: 4, name: "Drinks", imageName: "Drinks", type: 0)
        let _ = newCategory(id: 5, name: "Groceries", imageName: "Groceries", type: 1)
        let _ = newCategory(id: 6, name: "Inbox", imageName: "Inbox", type: 2)
        let _ = newCategory(id: 7, name: "Photos", imageName: "Photos", type: 0)
        let _ = newCategory(id: 8, name: "Trips", imageName: "Trips", type: 1)
    }
    
    // Wallet
    func newWallet(id: Int16, name: String, currentMoney: Double) {
        let wallet = Wallet(context: managedObjectContext)
        wallet.id = id
        wallet.name = name
        wallet.currentMoney = currentMoney
    }
    
    func initializeDefaultWallet() {
        let _ = newWallet(id: 1, name: "Effort", currentMoney: 0.0)
    }
    
    func getDefaultWallet() -> Wallet {
        let fetchRequest: NSFetchRequest<Wallet> = Wallet.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", "Effort")
        fetchRequest.predicate = predicate
        var wallet = Wallet()
        
        managedObjectContext.performAndWait {
            do {
                let filterWallets = try fetchRequest.execute()
                if filterWallets.isEmpty {
                    initializeDefaultWallet()
                    wallet = getDefaultWallet()
                } else {
                    wallet = filterWallets.first!
                }
            } catch {
                print("Can not search for wallet")
            }
        }
        
        return wallet
    }
}
