//
//  CreateTaskConfigurator.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 10/31/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension CreateTaskTableViewController: CreateTaskPresenterOutput
{
    func displaySomething(viewModel: CreateTaskViewModel) {
    }
}

extension CreateTaskInteractor: CreateTaskTableViewControllerOutput
{
    func sendText(request: CreateTaskRequest) {
    }
}

extension CreateTaskPresenter: CreateTaskInteractorOutput
{
}

class CreateTaskConfigurator
{
    // MARK: Object lifecycle
    
    class var sharedInstance: CreateTaskConfigurator
    {
        struct Static {
            static var instance: CreateTaskConfigurator?
            static var token = {0}()
        }
        
        _ = Static.token
        
        return Static.instance!
    }
    
    // MARK: Configuration
    
    func configure(viewController: CreateTaskTableViewController)
    {
        let presenter = CreateTaskPresenter()
        presenter.output = viewController
        
        let interactor = CreateTaskInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
    }
}
