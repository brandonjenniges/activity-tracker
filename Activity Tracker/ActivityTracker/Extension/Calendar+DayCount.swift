//
//  Calendar+DayCount.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/21/21.
//

import Foundation

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let from = startOfDay(for: from)
        let to = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: from, to: to)
        return numberOfDays.day ?? 0
    }
}
