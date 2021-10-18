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
            returnGroup.append(ActivitySessionGroup(date: group.key, sessions: group.value))
        }
        self.activityGroups = returnGroup
    }
    
}

struct ActivitySessionGroup: Identifiable {
    let date: String
    let sessions: [ActivitySession]
    
    var id: String {
        date
    }
}
