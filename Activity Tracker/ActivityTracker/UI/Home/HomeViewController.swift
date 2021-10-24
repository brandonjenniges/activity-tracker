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
        self.setupObservables()
    }
    
    // MARK: - Combine
    
    private func setupObservables() {
        self.viewModel.createNewActivity.sink { [weak self] in
            guard let self = self else { return }
            self.present(CreateActivityViewController(), animated: true, completion: nil)
        }
        .store(in: &self.disposeBag)
    }
}

