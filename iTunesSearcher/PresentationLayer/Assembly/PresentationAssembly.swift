//
//  PresentationAssembly.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 15.01.2021.
//

import Foundation

class PresentationAssembly: IPresentationAssembly {
    
    // MARK: - Private properties
    
    private let serviceAssembly: IServicesAssembly
    
    // MARK: - Initializer
    
    init(serviceAssembly: IServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    // MARK: - IPresentationAssembly
    
    func mainTabBarController() -> MainTabBarController {
        let controller = MainTabBarController()
        controller.rootVCModels = [
            .init(viewController: searchViewController(), title: "Search", imageName: "search"),
            .init(viewController: historyViewController(), title: "History", imageName: "history"),
        ]
        return controller
    }
    
    func searchViewController(searchQuery: String? = nil) -> SearchViewController {
        let searchViewController = SearchViewController()
        searchViewController.presenter = SearchPresenter(presentationAssembly: self,
                                                         searchService: serviceAssembly.searchService(),
                                                         searchQueriesRepository: serviceAssembly.searchQueriesRepository())
        if searchQuery != nil {
            searchViewController.searchQuery = searchQuery
        }
        return searchViewController
    }
    
    func historyViewController() -> HistoryViewController {
        let historyViewController = HistoryViewController()
        historyViewController.presenter = HistoryPresenter(presentationAssembly: self,
                                                           searchQueriesRepository: serviceAssembly.searchQueriesRepository())
        return historyViewController
    }
    
    func albumDetailsViewController(album: AlbumModel) -> AlbumDetailsViewController {
        let presenter = AlbumDetailsPresenter(album: album,
                                              searchService: serviceAssembly.searchService())
        let albumDetailsViewController = AlbumDetailsViewController()
        albumDetailsViewController.presenter = presenter
        return albumDetailsViewController
    }
}
