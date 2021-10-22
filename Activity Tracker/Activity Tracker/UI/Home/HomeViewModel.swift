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
    @Published var chartEntries: [ActivityChartItem] = []
    @Published var chartMin: Double = 0
    @Published var chartMax: Double = 0
    
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
        
        var currentMin: Double = 0
        var currentMax: Double = 0
        
        let calendar = Calendar.current
        let gap = calendar.numberOfDaysBetween(earliestDate, and: lastDate) + 1
        
        var pushupData: [Double] = Array.init(repeating: 0, count: gap)
        var situpData: [Double] = Array.init(repeating: 0, count: gap)
        var squatData: [Double] = Array.init(repeating: 0, count: gap)
        var totalData: [Double] = Array.init(repeating: 0, count: gap)
        
        for item in groups {
            let currentDateGap = calendar.numberOfDaysBetween(earliestDate, and: item.date)
            
            let pushupNumber =  item.sessions.filter { $0.type == ActivityType.pushup.rawValue }.reduce(0.0) { $0 + Double($1.reps) }
            pushupData[currentDateGap] = pushupNumber
            
            let situpNumber = item.sessions.filter { $0.type == ActivityType.situp.rawValue }.reduce(0.0) { $0 + Double($1.reps) }
            situpData[currentDateGap] = situpNumber
            
            let squatNumber = item.sessions.filter { $0.type == ActivityType.squat.rawValue }.reduce(0.0) { $0 + Double($1.reps) }
            squatData[currentDateGap] = squatNumber
            
            let totalNumber = pushupNumber + situpNumber + squatNumber
            totalData[currentDateGap] = totalNumber
            
            currentMin = min(currentMin, pushupNumber, situpNumber, squatNumber)
            currentMax = max(currentMax, totalNumber)
        }
        
        let pushupChartItem = ActivityChartItem(color: ActivityType.pushup.color(), data: pushupData)
        let situpChartItem = ActivityChartItem(color: ActivityType.situp.color(), data: situpData)
        let squatChartItem = ActivityChartItem(color: ActivityType.squat.color(), data: squatData)
        let totalChartItem = ActivityChartItem(color: .orange, data: totalData)
        
        self.chartMin = currentMin
        self.chartMax = currentMax
        self.chartEntries = [situpChartItem, squatChartItem, pushupChartItem, totalChartItem]
        
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
