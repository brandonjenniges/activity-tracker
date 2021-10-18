//
//  CreateActivityViewController.swift
//  Activity Tracker
//
//  Created by Brandon Jenniges on 10/17/21.
//

import SwiftUI
import Combine

class CreateActivityViewController: UIHostingController<CreateActivityView> {
    
    let viewModel: CreateActivityViewModel
    
    private var disposeBag: [AnyCancellable] = []
    
    init(viewModel: CreateActivityViewModel = CreateActivityViewModel()) {
        self.viewModel = viewModel
        super.init(rootView: CreateActivityView(viewModel: viewModel))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

