//
//  LoadImageDataOperation.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import UIKit

class LoadImageDataOperation: Operation {
    
    // MARK: - Private properties
    
    private let networkManager: INetworkManager
    private let url: URL
    private let completion: (Result<Data, SearchServiceError>) -> Void
    
    init(networkManager: INetworkManager,
         url: URL,
         completion: @escaping (Result<Data, SearchServiceError>) -> Void) {
        self.networkManager = networkManager
        self.url = url
        self.completion = completion
    }
    
    override func main() {
        if isCancelled { return }
        
        let request = RequestFactory.getImageDataRequest(forUrl: url)
        
        networkManager.makeRequest(request,
                                   session: URLSession.shared) { result in
            if self.isCancelled == true { return }
            switch result {
            case .failure:
                self.completion(.failure(.error))
            case .success(let data):
                self.completion(.success(data))
            }
        }
    }
}
