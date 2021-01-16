//
//  MainTabBarController.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 15.01.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Public properties
    
    var rootVCModels: [TabBarRootVCModel]? {
        didSet {
            viewControllers = rootVCModels?.map { createRootVc(rootVCModel: $0) }
        }
    }
    
    private func createRootVc(rootVCModel: TabBarRootVCModel) -> UIViewController {
        let viewController = rootVCModel.viewController
        viewController.navigationItem.title = rootVCModel.title
        if #available(iOS 13, *) {
            viewController.view.backgroundColor = .systemBackground
        } else {
            viewController.view.backgroundColor = .white
        }
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = rootVCModel.title
        navController.tabBarItem.image = UIImage(named: rootVCModel.imageName)
        
        return navController
    }
}
