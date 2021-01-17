//
//  SearchResult.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import Foundation

struct SearchResult<T: Codable>: Codable {
    let resultCount: Int
    let results: [T]
}
