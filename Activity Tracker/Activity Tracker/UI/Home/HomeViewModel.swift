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
    @Published var activities: [ActivitySession] = []
    @Published var activityGroups: [ActivitySessionGroup] = []
    
    private var disposeBag: [AnyCancellable] = []
    
    let createNewActivity = PassthroughSubject<Void, Never>()
    init() {
        ActivityStorage.shared.activites.eraseToAnyPublisher().sink { [weak self] activities in
            guard let self = self else { return }
            self.organizeActivities(activities)
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
