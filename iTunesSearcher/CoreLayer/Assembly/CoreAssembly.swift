//
//  CoreAssembly.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import Foundation

class CoreAssembly: ICoreAssembly {
    
    // MARK: - ICoreAssembly
    
    func networkManager() -> INetworkManager {
        return NetworkManager()
    }
}
