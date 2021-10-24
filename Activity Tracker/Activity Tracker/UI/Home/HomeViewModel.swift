//
//  HomeViewModel.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/17/21.
//

import SwiftUI
import Combine
import CoreData

class HomeViewModel: ObservableObject {
    @Published var chartData: ActivityChartItem?
    
    @Published var activities: [ActivitySession] = []
    @Published var activityGroups: [ActivitySessionGroup] = []
    
    private var disposeBag: [AnyCancellable] = []
    
    let createNewActivity = PassthroughSubject<Void, Never>()
    init() {
        ActivityStorage.shared.activites.eraseToAnyPublisher().sink { [weak self] activities in
            guard let self = self else { return }
            self.activities = activities
            self.organizeActivities(activities)
        }
        .store(in: &self.disposeBag)
        
        self.$activityGroups.sink { [weak self] groups in
            guard let self = self else { return }
            self.organizeChartData(groups)
        }
        .store(in: &self.disposeBag)
    }
    
    private func organizeActivities(_ activities: [ActivitySession]) {
        var groups = [String: [ActivitySession]]()
        for activity in activities {
            if groups[activity.dayString] == nil {
                groups[activity.dayString] = [activity]
            } else {
                groups[activity.dayString]?.append(activity)
            }
        }
        
        var returnGroup = [ActivitySessionGroup]()
        for group in groups {
            returnGroup.append(ActivitySessionGroup(displayDate: group.key, sessions: group.value.sorted { $0.date > $1.date }))
        }
        self.activityGroups = returnGroup.sorted {
            $0.date > $1.date
        }
    }
    
    private func organizeChartData(_ groups: [ActivitySessionGroup]) {
        guard let earliestDate = self.activities.first?.date, let lastDate = self.activities.last?.date else { return }
        
        let calendar = Calendar.current
        let gap = calendar.numberOfDaysBetween(earliestDate, and: lastDate) + 1
        
        var totalData: [Double] = Array.init(repeating: 0, count: gap)
        
        for item in groups {
            let currentDateGap = calendar.numberOfDaysBetween(earliestDate, and: item.date)
            let totalNumber = item.sessions.reduce(0.0) { $0 + Double($1.reps) }
            totalData[currentDateGap] = totalNumber
        }
        
        self.chartData = ActivityChartItem(color: .orange, data: totalData)
    }
}

struct ActivitySessionGroup: Identifiable {
    let displayDate: String
    let date: Date
    let sessions: [ActivitySession]
    
    init(displayDate: String, sessions: [ActivitySession]) {
        self.displayDate = displayDate
        self.date = DateUtils.dateFormatter.date(from: displayDate) ?? Date()
        self.sessions = sessions
    }
    var id: String {
        displayDate
    }
}
