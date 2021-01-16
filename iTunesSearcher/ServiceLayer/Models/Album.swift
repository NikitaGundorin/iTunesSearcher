//
//  Album.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import Foundation

struct Album: Codable {
    let collectionId: Int64
    let artistName: String?
    let collectionName: String?
    let artworkUrl100: URL?
    let trackCount: Int?
    let copyright: String?
    let releaseDate: Date?
    let primaryGenreName: String?
}
