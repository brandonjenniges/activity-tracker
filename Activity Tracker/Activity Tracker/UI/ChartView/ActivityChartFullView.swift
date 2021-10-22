//
//  ActivityChartFullView.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/21/21.
//

import SwiftUI

struct ActivityChartFullView: View {
    
    let data: [ActivityChartItem]
    let max: Double
    let min: Double
    
    var body: some View {
        VStack(spacing: 16) {
            
            ActivityChartView(data: data, max: max, min: min)
            
            HStack {
                Spacer()
                legendItem(for: .pushup)
                legendItem(for: .situp)
                legendItem(for: .squat)
                ActivityChartLegendItemView(title: "Total", color: .orange)
                Spacer()
            }
            .padding()
            
        }
    }
    
    private func legendItem(for activityType: ActivityType) -> some View {
        ActivityChartLegendItemView(title: activityType.displayString(), color: activityType.color())
    }
}
