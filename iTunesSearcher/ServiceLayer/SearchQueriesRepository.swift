//
//  SearchQueriesRepository.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 17.01.2021.
//

import Foundation

class SearchQueriesRepository: ISearchQueriesRepository {
    
    // MARK: - Private properties
    
    private let coreDataManager: ICoreDataManager
    
    // MARK: - Initializer
    
    init(coreDataManager: ICoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - ISearchQueriesRepository
    
    func saveSearchQuery(term: String) {
        coreDataManager.performSave { [weak self] context in
            if let query = self?.coreDataManager.fetchEntities(withName: "SearchQueryDB",
                                                               withPredicate: .init(format: "term == %@",
                                                                                    term))?.first as? SearchQueryDB {
                query.date = Date()
            } else {
                let _ = SearchQueryDB(searchQuery: SearchQuery(date: Date(), term: term),
                                      context: context)
            }
        }
    }
    
    func getSearchQueries(completion: @escaping ([SearchQuery]) -> Void) {
        if let searchQueriesDB = coreDataManager.fetchEntities(withName: "SearchQueryDB",
                                                               withPredicate: nil) as? [SearchQueryDB] {
            let searchQueries = searchQueriesDB
                .compactMap { SearchQuery(date: $0.date, term: $0.term) }
                .sorted(by: { $0.date > $1.date })
            completion(searchQueries)
        }
    }
}
