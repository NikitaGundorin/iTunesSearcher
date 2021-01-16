//
//  SearchResult.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import Foundation

struct SearchResult: Codable {
    let resultCount: Int
    let results: [Album]
}
