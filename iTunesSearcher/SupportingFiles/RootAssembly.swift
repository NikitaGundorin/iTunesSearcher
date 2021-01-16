//
//  RootAssembly.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 15.01.2021.
//

import Foundation

class RootAssembly {
    lazy var presentationAssembly: IPresentationAssembly = PresentationAssembly(serviceAssembly: self.serviceAssembly)
    lazy var serviceAssembly: IServicesAssembly = ServicesAssembly(coreAssembly: self.coreAssembly)
    lazy var coreAssembly: ICoreAssembly = CoreAssembly()
}
