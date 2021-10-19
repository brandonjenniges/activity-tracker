//
//  NavigationView.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/17/21.
//

import SwiftUI

struct NavigationView: View {
    
    let title: String?
    let leftItem: NavigationViewItemView?
    let rightItem: NavigationViewItemView?
    
    init(title: String? = nil, leftItem: NavigationViewItemView? = nil, rightItem: NavigationViewItemView? = nil) {
        self.title = title
        self.leftItem = leftItem
        self.rightItem = rightItem
    }
    
    var body: some View {
        VStack {
            HStack {
                leftItemView
                Spacer()
                Text(title ?? "")
                    .font(.title3)
                    .fontWeight(.black)
                Spacer()
                rightItemView
            }
            .padding(.top)
            .padding(.horizontal)
            Divider()
        }
    }
    
    @ViewBuilder
    private var leftItemView: some View {
        if let leftItem = leftItem {
            leftItem
        } else if let rightItem = rightItem {
            rightItem.hidden()
        } else {
            Spacer()
        }
    }
    
    @ViewBuilder
    private var rightItemView: some View {
        if let rightItem = rightItem {
            rightItem
        } else if let leftItem = leftItem {
            leftItem.hidden()
        } else {
            Spacer()
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView()
            NavigationView(title: "Create Activity")
            NavigationView(title: "Create Activity", leftItem: NavigationViewItemView(text: "Save", action: {}))
            NavigationView(title: "Create Activity", rightItem: NavigationViewItemView(text: "Save", action: {}))
            NavigationView(title: "Create Activity", leftItem: NavigationViewItemView(text: "Save", action: {}), rightItem: NavigationViewItemView(text: "Save", action: {}))
        }
        .previewLayout(.sizeThatFits)
    }
}
