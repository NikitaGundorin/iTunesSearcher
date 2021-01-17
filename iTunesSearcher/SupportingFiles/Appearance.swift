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
    
    static var regular12: UIFont {
        .systemFont(ofSize: 12)
    }
    
    static var regular14: UIFont {
        .systemFont(ofSize: 14)
    }
    
    static var semibold16: UIFont {
        .systemFont(ofSize: 16, weight: .semibold)
    }
}
