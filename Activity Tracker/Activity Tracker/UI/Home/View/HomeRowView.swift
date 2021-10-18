//
//  HomeRowView.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/17/21.
//

import SwiftUI

struct HomeRowView: View {
    
    let activitySession: ActivitySession
    
    var body: some View {
        HStack(spacing: 0) {
            Text(activitySession.sessionType)
                .fontWeight(.bold)
            Text(" - ")
            Text(activitySession.timeString)
            Spacer()
        }
    }
}

struct HomeRowView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let session = ActivitySession(context: context)
        session.type = ActivityType.pushup.rawValue
        session.date = Date()
        return HomeRowView(activitySession: session)
          .environment(\.managedObjectContext, context)
          .previewLayout(.fixed(width: 300, height: 50))
      }
}
