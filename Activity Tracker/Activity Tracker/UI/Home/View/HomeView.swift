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
    
    private let gridItemLayout: [GridItem] = Array(repeating: .init(.flexible(minimum: 40)), count: 2)
    
    var body: some View {
        VStack {
            navigationView
            Spacer()
            if self.viewModel.activityGroups.count > 0 {
                dataView
            } else {
                Text("NO Data")
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    @ViewBuilder
    private var navigationView: some View {
        NavigationView(title: "Activity Tracker", rightItem: NavigationViewItemView(text: "Create", action: { self.viewModel.createNewActivity.send() }))
    }
    
    @ViewBuilder
    private var dataView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ActivityChartFullView(data: self.viewModel.chartEntries, max: self.viewModel.chartMax, min: self.viewModel.chartMin)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                    
                )
                .padding(8)
            
            
            VStack {
                ForEach(viewModel.activityGroups) { group in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(group.displayDate)
                            .font(.title2)
                            .fontWeight(.bold)
                        Divider()
                            .padding(.bottom, 4)
                        
                        LazyVGrid(columns: gridItemLayout, spacing: 0) {
                            ForEach(group.sessions, id: \.self) { session in
                                HomeRowView(activitySession: session)
                                    .padding(.leading, 8)
                            }
                        }
                        
                        Spacer(minLength: 8)
                    }
                }
            }
            .padding(.horizontal, 8)
        }
        .padding(.bottom, 16)
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
