//
//  CreateActivityView.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/17/21.
//

import SwiftUI

struct CreateActivityView: View {
    @ObservedObject var viewModel: CreateActivityViewModel
    
    var body: some View {
        VStack {
            navigationView
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    typeView
                    repView
                    dateView
                }
                Spacer()
            }
            .padding()
            Spacer()
            PrimaryButton(title: "Create", type: .primary, enabled: viewModel.canCreate) {
                viewModel.createActivitySubject.send()
            }
        }
    }
    
    @ViewBuilder
    private var navigationView: some View {
        NavigationView(title: "Create", leftItem: NavigationViewItemView(text: "Cancel", action: { self.viewModel.cancelSubject.send() }))
    }
    
    @ViewBuilder
    private var typeView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Type:")
                .font(.title2)
                .fontWeight(.bold)
            
            Picker("Select Type", selection: $viewModel.selectedType, content: {
                Text(ActivityType.pushup.displayString()).tag(ActivityType.pushup)
                Text(ActivityType.situp.displayString()).tag(ActivityType.situp)
                Text(ActivityType.squat.displayString()).tag(ActivityType.squat)
            })
            .pickerStyle(SegmentedPickerStyle())
            
            Divider()
        }
    }
    
    @ViewBuilder
    private var repView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Reps:")
                .font(.title2)
                .fontWeight(.bold)
            HStack {
                TextField("Input" , text: $viewModel.repTextField)
                    .keyboardType(.numberPad)
                    .foregroundColor(.blue)
                    .padding(.leading, 16)
                    .font(.title3)
                    .onTapGesture {
                        self.viewModel.selectTypeSubject.send()
                    }
                presetRepButton(value: 10)
                presetRepButton(value: 20)
                presetRepButton(value: 50)
                presetRepButton(value: 100)
                Spacer()
            }
            Divider()
        }
    }
    
    @ViewBuilder
    private func presetRepButton(value: Int) -> some View {
        PrimaryButton(title: "\(value)", type: .primary, enabled: true) {
            self.viewModel.repTextField = "\(value)"
        }
    }
    
    @ViewBuilder
    private var dateView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Date:")
                .font(.title2)
                .fontWeight(.bold)
            DatePicker("Activity Date", selection: $viewModel.date,displayedComponents: .date)
                .font(.title3)
            Divider()
        }
    }
}

struct CreateActivityView_Previews: PreviewProvider {
    static var previews: some View {
        CreateActivityView(viewModel: CreateActivityViewModel())
    }
}
