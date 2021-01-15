//
//  CoreDataManager.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 15.01.2021.
//

import CoreData

class CoreDataManager: ICoreDataManager {
    
    // MARK: - Singleton
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    // MARK: - Core Data stack

    private let dataBaseName = "iTunesSearcher"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: dataBaseName)
        container.loadPersistentStores{ _,_  in }
        return container
    }()
    
    func fetchEntities(withName name: String,
                       withPredicate predicate: NSPredicate? = nil) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: name)
        fetchRequest.predicate = predicate
        
        return try? persistentContainer.viewContext.fetch(fetchRequest)
    }
    
    func performSave(block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask { context in
            block(context)
            if context.hasChanges {
                try? context.save()
            }
        }
    }
}
