//
//  CreateTaskConfigurator.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 10/31/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension CreateTaskViewController: CreateTaskPresenterOutput {
}

extension CreateTaskInteractor: CreateTaskViewControllerOutput {
}

extension CreateTaskPresenter: CreateTaskInteractorOutput {
}

class CreateTaskConfigurator {
    // MARK: Object lifecycle
    
    static let singleton = CreateTaskConfigurator()
    
    // MARK: Configuration
    
    func configure(viewController: CreateTaskViewController)
    {
        let presenter = CreateTaskPresenter()
        presenter.output = viewController
        
        let interactor = CreateTaskInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
    }
}
