//
//  CoreDataManager.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 6/08/21.
//

import Foundation

import CoreData

class CoreDataManager: DataManagerContract {
    
    let databaseName = "signupdb"
    
    var managedObjectContext: NSManagedObjectContext?
    
    private var model: NSManagedObjectModel?
    
    static let shared: CoreDataManager = {
        let instance = CoreDataManager()
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = urls[urls.endIndex - 1]
        let storeURL = docURL.appendingPathComponent(instance.databaseName + ".sqlite")

        guard let modelURL = Bundle.main.url(forResource: instance.databaseName, withExtension:"momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            print("Error on instancing NSManagedObjectModel...")
            fatalError("Error loading model from bundle")
        }
        
        instance.model = model
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        instance.managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        instance.managedObjectContext!.persistentStoreCoordinator = psc
        
        var success = false
        
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: [NSInferMappingModelAutomaticallyOption: true, NSMigratePersistentStoresAutomaticallyOption: true])

            success = true

        } catch {
            print("Error loading store persistence: \(error)")
            fatalError("Error migrating store.")
        }
        
        if success {
            print("Data persistence ready to work!.")
        }
        
        return instance
    }()
    
    func getContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: self.databaseName, managedObjectModel: self.model!)
        
        container.loadPersistentStores { (desc, err) in
            if let err = err {
                print("Error loading store \(desc): \(err)")
                return
            }
            print("Data persistence loaded ok!.")
        }
        
        return container
    }
    
    func saveContext() {
        let context = CoreDataManager.shared.getContainer().viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private init() { }
}
