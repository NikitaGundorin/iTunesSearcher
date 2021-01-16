//
//  ISearchService.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import Foundation

protocol ISearchService {
    func searchAlbums(forTerm term: String,
                      completion: @escaping (Result<[Album], SearchServiceError>) -> Void)
    func getAlbumImageData(forUrl url: URL, completion: @escaping (Result<Data, SearchServiceError>) -> Void)
}
