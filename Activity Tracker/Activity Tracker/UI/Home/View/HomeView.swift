//
//  HomeView.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/17/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        navigationView
        Spacer()
        Text("Hello World")
        Spacer()
    }
    
    @ViewBuilder
    private var navigationView: some View {
        NavigationView(title: "Create", leftItem: NavigationViewItemView(text: "Cancel", action: { }), rightItem: NavigationViewItemView(text: "Create", action: { }))
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
