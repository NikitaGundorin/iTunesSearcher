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
    
    func searchViewController() -> SearchViewController {
        let searchViewController = SearchViewController()
        searchViewController.presenter = SearchPresenter(searchService: serviceAssembly.searchService())
        return searchViewController
    }
    
    func historyViewController() -> HistoryViewController {
        return HistoryViewController()
    }
}
