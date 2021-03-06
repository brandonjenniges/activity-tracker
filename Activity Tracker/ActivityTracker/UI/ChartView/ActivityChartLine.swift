//
//  ChartLine.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/21/21.
//

import SwiftUI

struct ActivityChartLine: View {
    let data: [Double]
    let color: Color
    let frame: CGRect
    private let max: Double
    private let min: Double
    
    init(data: [Double], color: Color, frame: CGRect) {
        self.data = data
        self.color = color
        self.frame = frame
        self.max = data.max() ?? 0.0
        self.min = data.min() ?? 0.0
    }
    
    var stepWidth: CGFloat {
        if data.count < 2 {
            return 0
        }
        return frame.size.width / CGFloat(data.count - 1)
    }
    
    var stepHeight: CGFloat {
        if min == max { return 0 }
        if (min <= 0) {
            return frame.size.height / CGFloat(max - min)
        } else{
            return frame.size.height / CGFloat(max + min)
        }
    }
    
    var path: Path {
        return Path.lineChart(points: self.data, step: CGPoint(x: stepWidth, y: stepHeight))
    }
    
    public var body: some View {
        self.path
            .stroke(self.color, style: StrokeStyle(lineWidth: 3, lineJoin: .round))
            .rotationEffect(.degrees(180), anchor: .center)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .drawingGroup()
    }
}
