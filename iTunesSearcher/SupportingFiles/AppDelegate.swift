//
//  AppDelegate.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 15.01.2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Public properties
    
    var window: UIWindow?
    
    // MARK: - Private properties
    
    private let rootAssembly = RootAssembly()
    
    // MARK: - Application lifecycle

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainTabBarController = rootAssembly.presentationAssembly.mainTabBarController()
        
        window = UIWindow()
        window?.rootViewController = mainTabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}
