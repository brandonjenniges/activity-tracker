//
//  HomeView.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/17/21.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            navigationView
            Spacer()
            ScrollView {
                VStack {
                    ForEach(viewModel.activityGroups) { group in
                        VStack {
                            Text(group.displayDate)
                            ForEach(group.sessions, id: \.self) { session in
                                HomeRowView(activitySession: session)
                        }
                    }
                  }
                }
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private var navigationView: some View {
        NavigationView(title: "Create", rightItem: NavigationViewItemView(text: "Create", action: { self.viewModel.createNewActivity.send() }))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceContainer.shared.container.viewContext
        let session = ActivitySession(context: context)
        session.type = ActivityType.pushup.rawValue
        session.date = Date()
        do {
            try? context.save()
        }
        return HomeView(viewModel: HomeViewModel())
            .environment(\.managedObjectContext, context)
    }
}
