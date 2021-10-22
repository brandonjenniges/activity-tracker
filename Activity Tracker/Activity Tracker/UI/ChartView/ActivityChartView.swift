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
    
    public var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading, spacing: 8) {
                ZStack{
                    ForEach(data) { lineItem in
                        GeometryReader{ reader in
                            ActivityChartLine(data: lineItem.data,
                                      color: lineItem.color,
                                      max: self.max, min: self.min,
                                 frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width , height: reader.frame(in: .local).height))
                            )
                            .offset(x: 0, y: 0)
                        }
                        .frame(width: geometry.frame(in: .local).size.width, height: 200)
                    }
                }
            }
        }
        .frame(height: 200)
    }
}
