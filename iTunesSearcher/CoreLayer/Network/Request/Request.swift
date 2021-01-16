//
//  Request.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import Foundation

struct Request<Parser>: IRequest where Parser: IParser {
    let httpMethod: HTTPMethod
    let url: URL?
    let parser: Parser
    let data: Data?
    let contentType: String?
    
    init(httpMethod: HTTPMethod,
         url: URL?,
         parser: Parser,
         data: Data? = nil,
         contentType: String? = nil) {
        self.httpMethod = httpMethod
        self.url = url
        self.parser = parser
        self.data = data
        self.contentType = contentType
    }
}
