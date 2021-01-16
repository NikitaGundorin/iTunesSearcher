//
//  SearchService.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import Foundation

class SearchService: ISearchService {
    
    // MARK: - Private properties
    
    private let networkManager: INetworkManager
    
    // MARK: - Initializer
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
    
    // MARK: - ISearchService
    
    func searchAlbums(forTerm term: String, completion: @escaping (Result<[Album], SearchServiceError>) -> Void) {
        let request = RequestFactory.searchAlbumsRequest(forTerm: term)
        networkManager.makeRequest(request,
                                   session: URLSession.shared) { result in
            switch result {
            case .failure:
                completion(.failure(.error))
            case .success(let model):
                completion(.success(model.results))
            }
        }
    }
    
    func getAlbumImageData(forUrl url: URL, completion: @escaping (Result<Data, SearchServiceError>) -> Void) {
        let request = RequestFactory.getImageDataRequest(forUrl: url)
        networkManager.makeRequest(request,
                                   session: URLSession.shared) { result in
            switch result {
            case .failure:
                completion(.failure(.error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
}

enum SearchServiceError: Error {
    case error
}
