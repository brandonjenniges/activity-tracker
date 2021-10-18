//
//  CreateActivityView.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/17/21.
//

import SwiftUI

struct CreateActivityView: View {
    @ObservedObject var viewModel: CreateActivityViewModel
    
    var body: some View {
        navigationView
    }
    
    @ViewBuilder
    private var navigationView: some View {
        NavigationView(title: "Create", leftItem: NavigationViewItemView(text: "Cancel", action: { }), rightItem: NavigationViewItemView(text: "Create", action: { }))
    }
}

struct CreateActivityView_Previews: PreviewProvider {
    static var previews: some View {
        CreateActivityView(viewModel: CreateActivityViewModel())
    }
}
