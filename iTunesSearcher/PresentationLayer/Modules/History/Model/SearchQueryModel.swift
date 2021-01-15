//
//  SearchQueryModel.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 17.01.2021.
//

import Foundation

struct SearchQueryModel {
    let date: Date
    let term: String
}

struct SearchQueriesWithDateModel {
    let date: Date
    var dateText: String {
        date.isToday ? "Today" : date.isYesterday ? "Yesterday" : date.formatted()
    }
    let queries: [SearchQueryModel]
}
