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
    func loadAlbumImage(albumId: Int64,
                        completion: @escaping (Result<UIImage?, SearchServiceError>) -> Void)
    func cancelLoading()
    func showAlbumDetails(viewController: UIViewController, albumId: Int64)
}

class SearchPresenter: ISearchPresenter {
    
    // MARK: - Private properties
    
    private let presentationAssembly: IPresentationAssembly
    private let searchService: ISearchService
    private var timer: Timer?
    private let searchDelay = 0.5
    private var albums: [Int64: AlbumModel] = [:]
    
    // MARK: - Initializer
    
    init(presentationAssembly: IPresentationAssembly,
         searchService: ISearchService) {
        self.presentationAssembly = presentationAssembly
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
                    let albumModels =
                        albums.sorted { $0.collectionName?.lowercased() ?? "" < $1.collectionName?.lowercased() ?? "" }
                        .map { AlbumCellModel(albumId: $0.collectionId,
                                                                  imageUrl: $0.artworkUrl100,
                                                                  image: nil) }
                    albums.forEach { self?.albums[$0.collectionId] = AlbumModel(album: $0) }
                    DispatchQueue.main.async {
                        completion(.success(albumModels))
                    }
                }
            }
        }
    }
    
    func loadAlbumImage(albumId: Int64, completion: @escaping (Result<UIImage?, SearchServiceError>) -> Void) {
        guard let url = albums[albumId]?.imageUrl else { return }
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
    
    func showAlbumDetails(viewController: UIViewController, albumId: Int64) {
        guard let album = albums[albumId] else { return }
        let detailsVC = presentationAssembly.albumDetailsViewController(album: album)
        viewController.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
