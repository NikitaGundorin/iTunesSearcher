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
    private lazy var operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "com.itunessearcher"
        queue.qualityOfService = .userInitiated
        queue.maxConcurrentOperationCount = 5
        return queue
    }()
    
    // MARK: - Initializer
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
    
    // MARK: - ISearchService
    
    func searchAlbums(forTerm term: String, completion: @escaping (Result<[Album], SearchServiceError>) -> Void) {
        cancelLoading()
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
        let operation = LoadImageDataOperation(networkManager: networkManager,
                                               url: url,
                                               completion: completion)
        operationQueue.addOperation(operation)
    }
    
    func cancelLoading() {
        operationQueue.cancelAllOperations()
    }
}

enum SearchServiceError: Error {
    case error
}
