//
//  ActivityChartLegendItemView.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/21/21.
//

import SwiftUI

struct ActivityChartLegendItemView: View {
    let title: String
    let color: Color
    
    var body: some View {
        HStack {
            color
                .frame(width: 20, height: 20)
            Text(title)
                .font(.caption)
                .fontWeight(.black)
        }
    }
}

struct ActivityChartLegendItemView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityChartLegendItemView(title: "Push-up", color: .red)
    }
}
