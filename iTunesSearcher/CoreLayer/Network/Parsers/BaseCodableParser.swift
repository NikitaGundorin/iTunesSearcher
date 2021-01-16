//
//  BaseCodableParser.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import Foundation

class BaseCodableParser<Model>: IParser where Model: Decodable {
    func parse(data: Data) -> Model? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try? decoder.decode(Model.self, from: data)
    }
}
