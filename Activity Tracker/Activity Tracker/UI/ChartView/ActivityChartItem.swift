//
//  ChartLineItem.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/21/21.
//

import Foundation
import SwiftUI

struct ActivityChartItem {
    let color: Color
    let data: [Double]
}

extension ActivityChartItem: Identifiable {
    var id: Int {
        color.hashValue
    }
}
