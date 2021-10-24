//
//  ActivitySession+CoreDataProperties.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/17/21.
//

import CoreData
import SwiftUI

extension ActivitySession {
    @NSManaged var type: Int
    @NSManaged var reps: Int
    @NSManaged var date: Date
    
    @nonobjc public class func basicFetchRequest() -> NSFetchRequest<ActivitySession> {
        let request = NSFetchRequest<ActivitySession>(entityName: "ActivitySession")
        let sort = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sort]
        return request
    }
    
}

extension ActivitySession {
    var sessionType: String {
        (ActivityType(rawValue: self.type) ?? .pushup).displayString()
    }
    
    var typeColor: Color {
        (ActivityType(rawValue: self.type) ?? .pushup).color()
    }
}
