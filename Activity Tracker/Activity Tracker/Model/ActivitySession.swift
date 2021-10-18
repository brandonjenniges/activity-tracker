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

extension ActivitySession {
    @NSManaged var type: Int
    @NSManaged var reps: Int
    @NSManaged var date: Date
    
    static func createWith(type: ActivityType,
                           reps: Int,
                           date: Date,
                           using context: NSManagedObjectContext) {
        let session = ActivitySession(context: context)
        session.type = type.rawValue
        session.reps = reps
        session.date = date
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    static func basicFetchRequest() -> FetchRequest<ActivitySession> {
        FetchRequest(entity: ActivitySession.entity(), sortDescriptors: [])
    }
    
}

extension ActivitySession {
    var sessionType: String {
        (ActivityType(rawValue: self.type) ?? .pushup).displayString()
    }
}
