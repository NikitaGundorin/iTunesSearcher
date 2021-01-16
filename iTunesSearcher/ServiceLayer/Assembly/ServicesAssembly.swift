//
//  ServicesAssembly.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import Foundation

class ServicesAssembly: IServicesAssembly {
    
    // MARK: - Private properties
    
    private let coreAssembly: ICoreAssembly
    
    // MARK: - Initializer
    
    init(coreAssembly: ICoreAssembly) {
        self.coreAssembly = coreAssembly
    }
    
    // MARK: - IServicesAssembly
    
    func searchService() -> ISearchService {
        return SearchService(networkManager: coreAssembly.networkManager())
    }
}
