//
//  ActivitySession.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/17/21.
//

import CoreData
import SwiftUI

@objc(ActivitySession)
public class ActivitySession: NSManagedObject {
    lazy var dayString: String = {
        DateUtils.displayRowDate(date: self.date)
    }()
    
    lazy var timeString: String = {
        DateUtils.displaySessionDate(date: self.date)
    }()
}
