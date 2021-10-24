//
//  Path+ChartLine.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/21/21.
//

import SwiftUI

extension Path {
    
    static func lineChart(points: [Double], step: CGPoint) -> Path {
        var path = Path()
        if (points.count < 1) {
            return path
        }
        let p1 = CGPoint(x: 0, y: CGFloat(points[0]) * step.y)
        path.move(to: p1)
        for pointIndex in 1..<points.count {
            let p2 = CGPoint(x: step.x * CGFloat(pointIndex), y: step.y * CGFloat(points[pointIndex]))
            path.addLine(to: p2)
        }
        return path
    }
}
