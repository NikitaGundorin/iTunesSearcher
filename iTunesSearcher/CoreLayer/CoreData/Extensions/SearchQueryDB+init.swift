//
//  SearchQueryDB+init.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 17.01.2021.
//

import CoreData

extension SearchQueryDB {
    convenience init(searchQuery: SearchQuery, context: NSManagedObjectContext) {
        self.init(context: context)
        
        date = searchQuery.date
        term = searchQuery.term
    }
}
