//
//  ISearchQueriesRepository.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 17.01.2021.
//

import Foundation

protocol ISearchQueriesRepository {
    func saveSearchQuery(term: String)
    func getSearchQueries(completion: @escaping ([SearchQuery]) -> Void)
}
