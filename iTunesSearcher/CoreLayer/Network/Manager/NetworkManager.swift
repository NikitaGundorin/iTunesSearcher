//
//  NetworkManager.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import Foundation

class NetworkManager: INetworkManager {
    
    func makeRequest<Request>(_ request: Request,
                              session: URLSession,
                              completion: @escaping (Result<Request.Parser.Model, NetworkError>) -> Void) where Request: IRequest {
        guard let url = request.url else {
            return completion(.failure(.invalidUrl))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        if request.httpMethod != .get, let data = request.data {
            if let contentType = request.contentType {
                urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
            }
            urlRequest.httpBody = data
        }
        
        let task = session.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                return completion(.failure(.badRequest))
            }
            
            guard let result = request.parser.parse(data: data) else {
                return completion(.failure(.invalidData))
            }
            
            return completion(.success(result))
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            task.resume()
        }
    }
}
