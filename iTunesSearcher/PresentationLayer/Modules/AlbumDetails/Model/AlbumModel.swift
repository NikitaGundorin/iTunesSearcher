//
//  AlbumModel.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 17.01.2021.
//

import UIKit

struct AlbumModel {
    let albumId: Int64
    let artistName: String?
    let albumName: String?
    let imageUrl: URL?
    let trackCount: Int?
    let copyright: String?
    let releaseDate: Date?
    let genreName: String?
    var image: UIImage?
    var tracks: [TrackCellModel]
    
    init(album: Album) {
        albumId = album.collectionId
        artistName = album.artistName
        albumName = album.collectionName
        imageUrl = album.artworkUrl100
        trackCount = album.trackCount
        copyright = album.copyright
        releaseDate = album.releaseDate
        genreName = album.primaryGenreName
        tracks = []
    }
}
