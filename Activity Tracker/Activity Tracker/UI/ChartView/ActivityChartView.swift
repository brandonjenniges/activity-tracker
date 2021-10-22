//
//  ActivityChartView.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/21/21.
//

import UIKit
import SwiftUI

struct ActivityChartView: View {
    
    let data: [ActivityChartItem]
    let max: Double
    let min: Double
    
    private let viewHeight: Double = 200
    
    public var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .bottom) {
                    ForEach(data) { lineItem in
                        GeometryReader{ reader in
                            ActivityChartLine(data: lineItem.data,
                                              color: lineItem.color,
                                              max: self.max,
                                              min: self.min,
                                              frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width, height: reader.frame(in: .local).height))
                            )
                        }
                        .frame(width: geometry.frame(in: .local).size.width, height: viewHeight * ((lineItem.data.max() ?? max) / max))
                    }
                }
            }
        }
        .frame(height: viewHeight)
    }
}
