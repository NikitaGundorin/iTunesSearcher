//
//  AlbumDetailsPresenter.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 17.01.2021.
//

import UIKit

protocol IAlbumDetailsPresenter {
    var album: AlbumModel { get }
    func loadAlbumDetails(completion: @escaping (Bool) -> Void)
}

class AlbumDetailsPresenter: IAlbumDetailsPresenter {
    
    // MARK: - Public properties
    
    private(set) var album: AlbumModel
    
    // MARK: - Private properties
    
    private let searchService: ISearchService
    
    // MARK: - Initializer
    
    init(album: AlbumModel, searchService: ISearchService) {
        self.album = album
        self.searchService = searchService
    }
    
    func loadAlbumDetails(completion: @escaping (Bool) -> Void) {
        guard let imageUrl = album.imageUrl?.absoluteString,
              let largeSizeImageUrl = URL(string: imageUrl.replacingOccurrences(of: "100x100", with: "600x600"))
        else { return }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.searchService.loadAlbumDetails(albumId: self.album.albumId,
                                                imageUrl: largeSizeImageUrl) { [weak self] result in
                switch result {
                case .failure:
                    DispatchQueue.main.async {
                        completion(true)
                    }
                case .success(let (traks, imageData, hasErrors)):
                    self?.album.tracks = traks.map { TrackCellModel(name: $0.trackName) }
                    if let data = imageData {
                        self?.album.image = UIImage(data: data)
                    }
                    DispatchQueue.main.async {
                        completion(hasErrors)
                    }
                }
            }
        }
    }
}
