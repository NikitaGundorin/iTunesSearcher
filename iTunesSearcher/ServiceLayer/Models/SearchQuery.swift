//
//  SearchQuery.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 17.01.2021.
//

import Foundation

struct SearchQuery {
    let date: Date
    let term: String
}

extension SearchQuery {
    init?(date: Date?, term: String?) {
        guard let date = date,
              let term = term else { return nil }
        
        self.date = date
        self.term = term
    }
}
