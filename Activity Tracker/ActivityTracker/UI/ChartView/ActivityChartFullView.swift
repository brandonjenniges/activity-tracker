//
//  ActivityChartFullView.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/21/21.
//

import SwiftUI

struct ActivityChartFullView: View {
    
    let data: ActivityChartItem
    private let max: Int
    private let min: Int
    private let average: Int
    private let weekAverage: Int
    
    init(data: ActivityChartItem) {
        self.data = data
        self.max = Int(data.data.max() ?? 0)
        self.min = Int(data.data.min() ?? 0)
        self.average = Int(data.data.reduce(0.0, +) / Double(data.data.count))
        self.weekAverage = Int(data.data.suffix(7).reduce(0.0, +) / Double(data.data.suffix(7).count))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ActivityChartView(data: data)
            Divider()
            HStack(spacing: 8) {
                Text("High: ")
                    .font(.caption) +
                Text("\(max)")
                    .font(.body)
                Color.black.clipShape(Circle()).frame(width: 4, height: 4)
                Text("Low: ")
                    .font(.caption) +
                Text("\(min)")
                    .font(.body)
                Color.black.clipShape(Circle()).frame(width: 4, height: 4)
                Text("Avg: ")
                    .font(.caption) +
                Text("\(average)")
                    .font(.body)
                Color.black.clipShape(Circle()).frame(width: 4, height: 4)
                Text("7 Day: ")
                    .font(.caption) +
                Text("\(weekAverage)")
                    .font(.body)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
            
        }
    }
}
