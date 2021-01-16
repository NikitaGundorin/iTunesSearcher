//
//  IRequest.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import Foundation

protocol IRequest {
    associatedtype Parser: IParser
    
    var httpMethod: HTTPMethod { get }
    var url: URL? { get }
    var data: Data? { get }
    var contentType: String? { get }
    var parser: Parser { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
