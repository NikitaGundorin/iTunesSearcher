//
//  ICoreDataManager.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 17.01.2021.
//

import CoreData

protocol ICoreDataManager {
    func fetchEntities(withName name: String,
                       withPredicate predicate: NSPredicate?) -> [NSManagedObject]?
    
    func performSave(block: @escaping (NSManagedObjectContext) -> Void)
}
