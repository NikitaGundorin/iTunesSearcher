//
//  IPresentationAssembly.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 15.01.2021.
//

import Foundation

protocol IPresentationAssembly {
    func mainTabBarController() -> MainTabBarController
    func searchViewController() -> SearchViewController
    func historyViewController() -> HistoryViewController
    func albumDetailsViewController(album: AlbumModel) -> AlbumDetailsViewController
}
