//
//  ActivityChartView.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/21/21.
//

import UIKit
import SwiftUI

struct ActivityChartView: View {
    
    let data: ActivityChartItem
    
    private let viewHeight: Double = 200
    
    public var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .bottom) {
                    GeometryReader{ reader in
                        ActivityChartLine(data: data.data,
                                          color: data.color,
                                          frame: CGRect(x: 0, y: 0, width: reader.frame(in: .local).width, height: reader.frame(in: .local).height)
                        )
                    }
                    .frame(width: geometry.frame(in: .local).size.width, height: viewHeight)
                }
            }
        }
        .frame(height: viewHeight)
    }
}
