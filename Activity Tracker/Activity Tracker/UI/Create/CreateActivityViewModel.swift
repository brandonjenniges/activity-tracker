//
//  CreateActivityViewModel.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/17/21.
//

import SwiftUI
import Combine

class CreateActivityViewModel: ObservableObject {

    @Published var canCreate: Bool = false
    @Published var selectedType: ActivityType = .pushup
    @Published var repTextField: String = ""
    @Published var date: Date = Date()
    
    let selectTypeSubject = PassthroughSubject<Void, Never>()
    let cancelSubject = PassthroughSubject<Void, Never>()
    let createActivitySubject = PassthroughSubject<Void, Never>()
}
