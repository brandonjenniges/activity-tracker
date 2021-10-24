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
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .shadow(radius: 2)
                .background(ContainerRelativeShape()
                                .fill(activitySession.typeColor))
                .clipShape(Capsule())
            VStack(alignment: .leading, spacing: 0) {
                Text("\(activitySession.reps)")
                    .font(.caption)
                    .fontWeight(.bold)
                Text(activitySession.timeString)
                    .foregroundColor(Color(uiColor: UIColor.secondaryLabel))
                    .font(.caption2)
            }
            .padding(8)
            Spacer()
        }
    }
}

struct HomeRowView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceContainer.shared.container.viewContext
        let session = ActivitySession(context: context)
        session.type = ActivityType.pushup.rawValue
        session.date = Date()
        return HomeRowView(activitySession: session)
          .environment(\.managedObjectContext, context)
          .previewLayout(.fixed(width: 300, height: 50))
      }
}
