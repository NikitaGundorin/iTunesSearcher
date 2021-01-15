//
//  Date+Format.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 17.01.2021.
//

import Foundation

extension Date {
    func formatted(with format: String = "dd.MM.YYYY") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }
}
