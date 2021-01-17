//
//  RequestFactory.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import Foundation

class RequestFactory {
    private static let baseUrl = "https://itunes.apple.com/"
    
    static func searchAlbumsRequest(forTerm term: String) -> Request<BaseCodableParser<SearchResult<Album>>> {
        let queryItems: [URLQueryItem] = [.init(name: "term", value: term),
                                          .init(name: "media", value: "music"),
                                          .init(name: "entity", value: "album")]
        var urlComponents = URLComponents(string: baseUrl + "search")
        urlComponents?.queryItems = queryItems
        return .init(httpMethod: .get, url: urlComponents?.url, parser: .init())
    }
    
    static func getImageDataRequest(forUrl url: URL) -> Request<DataParser> {
        return Request(httpMethod: .get, url: url, parser: DataParser())
    }
    
    static func getAlbumTrackListRequest(albumId: Int64) -> Request<BaseCodableParser<SearchResult<Track>>> {
        let queryItems: [URLQueryItem] = [.init(name: "id", value: "\(albumId)"),
                                          .init(name: "media", value: "music"),
                                          .init(name: "entity", value: "song")]
        var urlComponents = URLComponents(string: baseUrl + "lookup")
        urlComponents?.queryItems = queryItems
        return .init(httpMethod: .get, url: urlComponents?.url, parser: .init())
    }
}
