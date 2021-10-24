//
//  DateUtils.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/17/21.
//

import Foundation

class DateUtils {
    
    static let timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    static func displayRowDate(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    static func displaySessionDate(date: Date) -> String {
        return timeFormatter.string(from: date)
    }
}
