//
//  PresentationAssembly.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 15.01.2021.
//

import Foundation

class PresentationAssembly: IPresentationAssembly {
    
    func mainTabBarController() -> MainTabBarController {
        let controller = MainTabBarController()
        controller.rootVCModels = [
            .init(viewController: searchViewController(), title: "Search", imageName: "search"),
            .init(viewController: historyViewController(), title: "History", imageName: "history"),
        ]
        return controller
    }
    
    func searchViewController() -> SearchViewController {
        return SearchViewController()
    }
    
    func historyViewController() -> HistoryViewController {
        return HistoryViewController()
    }
}
