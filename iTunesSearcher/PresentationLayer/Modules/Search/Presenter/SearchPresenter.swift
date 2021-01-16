//
//  SearchPresenter.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import UIKit

protocol ISearchPresenter {
    func performSearch(forTerm term: String,
                       completion: @escaping (Result<[AlbumCellModel], SearchServiceError>) -> Void)
    func loadAlbumImage(forUrl url: URL,
                        completion: @escaping (Result<UIImage?, SearchServiceError>) -> Void)
    
    func cancelLoading()
}

class SearchPresenter: ISearchPresenter {
    
    // MARK: - Private properties
    
    private let searchService: ISearchService
    private var timer: Timer?
    private let searchDelay = 0.5
    
    // MARK: - Initializer
    
    init(searchService: ISearchService) {
        self.searchService = searchService
    }
    
    // MARK: - ISearchPresenter
    
    func performSearch(forTerm term: String,
                       completion: @escaping (Result<[AlbumCellModel], SearchServiceError>) -> Void) {
        timer?.invalidate()
        guard term.count > 0 else { return completion(.success([])) }
        timer = Timer.scheduledTimer(withTimeInterval: searchDelay, repeats: false) { [weak self]  _ in
            self?.searchService.searchAlbums(forTerm: term) { result in
                switch result {
                case .failure:
                    DispatchQueue.main.async {
                        completion(.failure(.error))
                    }
                case .success(let albums):
                    let albumModels = albums.map { AlbumCellModel(albumId: $0.collectionId,
                                                                  imageUrl: $0.artworkUrl100,
                                                                  image: nil) }
                    DispatchQueue.main.async {
                        completion(.success(albumModels))
                    }
                }
            }
        }
    }
    
    func loadAlbumImage(forUrl url: URL, completion: @escaping (Result<UIImage?, SearchServiceError>) -> Void) {
        searchService.getAlbumImageData(forUrl: url) { result in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    completion(.failure(.error))
                }
            case .success(let data):
                DispatchQueue.main.async {
                    completion(.success(UIImage(data: data)))
                }
            }
        }
    }
    
    func cancelLoading() {
        searchService.cancelLoading()
    }
}
