//
//  ActivityType.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/17/21.
//

import Foundation

enum ActivityType: Int {
    case pushup = 0
    case situp  = 1
    case squat  = 2
    
    func displayString() -> String {
        switch self {
        case .pushup:
            return "Push-up"
        case .situp:
            return "Sit-up"
        case .squat:
            return "Squat"
        }
    }
}
