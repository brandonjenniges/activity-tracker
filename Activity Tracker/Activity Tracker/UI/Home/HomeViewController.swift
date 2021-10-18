//
//  HomeViewController.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/17/21.
//

import SwiftUI
import Combine

class HomeViewController: UIHostingController<HomeView> {
    
    let viewModel: HomeViewModel
    
    private var disposeBag: [AnyCancellable] = []
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(rootView: HomeView(viewModel: viewModel))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.createNewActivity.sink {
            let context = PersistenceContainer.shared.container.viewContext
            ActivitySession.createWith(type: .pushup, reps: 10, date: Date(), using: context)
        }.store(in: &self.disposeBag)
    }
}

