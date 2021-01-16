//
//  INetworkManager.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import Foundation

protocol INetworkManager {
    func makeRequest<Request>(_ request: Request,
                              session: URLSession,
                              completion: @escaping (Result<Request.Parser.Model, NetworkError>) -> Void) where Request: IRequest
}

enum NetworkError: Error {
    case invalidUrl
    case badRequest
    case invalidData
}
