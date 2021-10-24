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
        self.modalPresentationStyle = .overCurrentContext
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
        self.viewModel.$repTextField.sink { [weak self] text in
            guard let self = self else { return }
            let repInt = Int(text) ?? 0
            self.viewModel.canCreate = repInt > 0
        }
        .store(in: &self.disposeBag)
        
        self.viewModel.createActivitySubject.sink { [weak self] in
            guard let self = self, self.viewModel.canCreate, let repInt = Int(self.viewModel.repTextField), repInt > 0 else { return }
            let context = PersistenceContainer.shared.container.viewContext
            ActivitySession.createWith(type: self.viewModel.selectedType, reps: repInt, date: self.viewModel.date, using: context)
            self.dismiss(animated: true, completion: nil)
        }
        .store(in: &self.disposeBag)
        
        self.viewModel.cancelSubject.sink { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)
        }
        .store(in: &self.disposeBag)
    }
    
    
}

