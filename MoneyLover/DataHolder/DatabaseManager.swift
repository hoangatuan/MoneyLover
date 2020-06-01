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
    case expenses = 0
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
    func newCategory(name: String, imageName: String, type: Int16) -> Category {
        let category = Category(context: managedObjectContext)
        category.name = name
        category.imageName = imageName
        category.type = type
        saveContext()
        return category
    }
    
    func getListDefaultCategory() -> [Category] {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Category.name), ascending: true)]
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
    
    func findCategoryByName(name: String) -> Category? {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        var category: Category?
        managedObjectContext.performAndWait {
            do {
                category = try fetchRequest.execute().first
            } catch let error {
                print("Can not search for Category by name: \(error)")
            }
        }
        
        return category
    }
    
    func initializeListDefaultCategory() {
        let _ = newCategory(name: "Appointments", imageName: "Appointments", type: 0)
        let _ = newCategory(name: "Birthdays", imageName: "Birthdays", type: 1)
        let _ = newCategory(name: "Chores", imageName: "Chores", type: 2)
        let _ = newCategory(name: "Drinks", imageName: "Drinks", type: 0)
        let _ = newCategory(name: "Groceries", imageName: "Groceries", type: 1)
        let _ = newCategory(name: "Inbox", imageName: "Inbox", type: 2)
        let _ = newCategory(name: "Photos", imageName: "Photos", type: 0)
        let _ = newCategory(name: "Trips", imageName: "Trips", type: 1)
    }
    
    // Wallet
    func newWallet(name: String, currentMoney: Double) {
        let wallet = Wallet(context: managedObjectContext)
        wallet.name = name
        wallet.currentMoney = currentMoney
        saveContext()
    }
    
    func initializeDefaultWallet() {
        let _ = newWallet(name: "Effort", currentMoney: 0.0)
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
    
    // MonthTransaction
    func newMonthTransaction(month: Int, year: Int) -> MonthTransaction {
        let monthTransaction = MonthTransaction(context: managedObjectContext)
        monthTransaction.month = Int16(month)
        monthTransaction.year = Int16(year)
        monthTransaction.wallet = getDefaultWallet()
        monthTransaction.moneyIn = 0.0
        monthTransaction.moneyOut = 0.0
        saveContext()
        return monthTransaction
    }
    
    func getMonthTransaction(month: Int, year: Int) -> MonthTransaction? {
        let fetchRequest: NSFetchRequest<MonthTransaction> = MonthTransaction.fetchRequest()
        let monthPredicate = NSPredicate(format: "month == %ld", month)
        let yearPredicate = NSPredicate(format: "year == %ld", year)
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [monthPredicate, yearPredicate])
        
        fetchRequest.predicate = andPredicate
        var result: MonthTransaction?
        managedObjectContext.performAndWait {
            do {
                result = try fetchRequest.execute().first
            } catch let error {
                print("Can not perform get Month Transaction: \(error)")
            }
        }
        
        return result
    }
    
    // DayTransaction
    func newDayTransaction(day: Int, monthTransaction: MonthTransaction) -> DayTransaction {
        let dayTransaction = DayTransaction(context: managedObjectContext)
        dayTransaction.day = Int16(day)
        dayTransaction.monthTransaction = monthTransaction
        saveContext()
        return dayTransaction
    }
    
    func getDayTransaction(date: Date) -> DayTransaction? {
        guard let monthTransaction = getMonthTransaction(month: date.month, year: date.year) else {
            return nil
        }
        
        let listDayTransactions = monthTransaction.dayTransactions?.allObjects as! [DayTransaction]
        return listDayTransactions.filter({
            $0.day == date.day
        }).first
    }
    
    // Transaction
    func newTransaction(money: Double, note: String?, weekDay: Int, category: Category, dayTransaction: DayTransaction) -> Transaction {
        let transaction = Transaction(context: managedObjectContext)
        transaction.money = money
        transaction.note = note
        transaction.category = category
        transaction.dayTransaction = dayTransaction
        transaction.weekDay = Int16(weekDay)
        saveContext()
        return transaction
    }
}
