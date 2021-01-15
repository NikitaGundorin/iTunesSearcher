//
//  HistoryPresenter.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 17.01.2021.
//

import UIKit

protocol IHistoryPresenter {
    var searchQueries: [SearchQueriesWithDateModel] { get }
    func showSearchViweController(from viewController: UIViewController,
                                  queryIndexPath: IndexPath)
    func updateHistory(completion: @escaping () -> Void)
}

class HistoryPresenter: IHistoryPresenter {
    
    // MARK: - Public properties
    
    private(set) var searchQueries: [SearchQueriesWithDateModel] = []
    
    // MARK: - Private properties
    
    private let presentationAssembly: IPresentationAssembly
    private let searchQueriesRepository: ISearchQueriesRepository
    
    // MARK: - Initializer
    
    init(presentationAssembly: IPresentationAssembly,
         searchQueriesRepository: ISearchQueriesRepository) {
        self.presentationAssembly = presentationAssembly
        self.searchQueriesRepository = searchQueriesRepository
    }
    
    // MARK: - IHistoryPresenter
    
    func showSearchViweController(from viewController: UIViewController, queryIndexPath: IndexPath) {
        let vc = presentationAssembly.searchViewController(searchQuery:
                                                            searchQueries[queryIndexPath.section]
                                                            .queries[queryIndexPath.row]
                                                            .term)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateHistory(completion: @escaping () -> Void) {
        searchQueriesRepository.getSearchQueries(completion: { [weak self] queries in
            let dates = Dictionary(grouping: queries) { query -> DateComponents in
                Calendar.current.dateComponents([.day, .year, .month], from: (query.date))
            }
            self?.searchQueries = dates.keys.compactMap { key in
                let queries = dates[key]?.map { query in
                    SearchQueryModel(date: query.date,
                                     term: query.term)
                }
                
                if let queries = queries, let date = Calendar.current.date(from: key) {
                    return SearchQueriesWithDateModel(date: date,
                                                      queries: queries)
                }
                return nil
            }.sorted(by: { $0.date > $1.date })
            completion()
        })
    }
}
