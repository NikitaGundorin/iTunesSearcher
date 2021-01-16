//
//  RequestFactory.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import Foundation

class RequestFactory {
    private static let baseUrl = "https://itunes.apple.com/"
    
    static func searchAlbumsRequest(forTerm term: String) -> Request<BaseCodableParser<SearchResult>> {
        let queryItems: [URLQueryItem] = [.init(name: "term", value: term),
                                          .init(name: "entity", value: "album")]
        var urlComponents = URLComponents(string: baseUrl + "search")
        urlComponents?.queryItems = queryItems
        return .init(httpMethod: .get, url: urlComponents?.url, parser: .init())
    }
    
    static func getImageDataRequest(forUrl url: URL) -> Request<DataParser> {
        return Request(httpMethod: .get, url: url, parser: DataParser())
    }
}
