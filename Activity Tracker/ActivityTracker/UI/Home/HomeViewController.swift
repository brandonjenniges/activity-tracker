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
        
        self.viewModel.modifyActivity.sink { [weak self] activity in
            guard let self = self else { return }
            self.showModifyAlert(activity)
        }
        .store(in: &self.disposeBag)
    }
    
    // MARK: - Modify Alert
    
    private func showModifyAlert(_ activity: ActivitySession) {
        let controller = UIAlertController(title: "Modify Activity", message: "Would you like to edit or delete this session?", preferredStyle: .alert)
        let editAction = UIAlertAction(title: "Edit", style: .default) { _ in
            let editActivityViewModel = CreateActivityViewModel(existingActivity: activity)
            self.present(CreateActivityViewController(viewModel: editActivityViewModel), animated: true, completion: nil)
        }
        let deleteAction  = UIAlertAction(title: "Delete", style: .destructive) { _ in
            ActivityStorage.shared.deleteActivity(activity)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        controller.addAction(editAction)
        controller.addAction(deleteAction)
        controller.addAction(cancelAction)
        self.present(controller, animated: true, completion: nil)
    }
}

