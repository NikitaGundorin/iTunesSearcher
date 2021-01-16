//
//  Appearance.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 16.01.2021.
//

import UIKit

class Appearance {
    static var backgroundColor: UIColor {
        if #available(iOS 13, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
}
