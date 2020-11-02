//
//  Formatter.swift
//  PayPark
//
//  Created by Nathan FG on 2020-10-16.
//

import Foundation

struct Formatter{
    func simplifiedDateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
    
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    
    dateFormatter.locale = Locale(identifier: "en_US")
    return dateFormatter.string(from:date)
    }
}
