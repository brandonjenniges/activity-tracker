//
//  NavigationViewItemView.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/17/21.
//

import SwiftUI

struct NavigationViewItemView: View {
    
    let text: String
    let action: () -> ()
    
    var body: some View {
        Text(text)
            .font(.body)
            .fontWeight(.bold)
            .foregroundColor(Color.blue)
            .padding(.vertical, 8)
            .onTapGesture {
                action()
            }
    }
}

struct NavigationViewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewItemView(text: "Save", action: {})
            .previewLayout(.sizeThatFits)
    }
}
