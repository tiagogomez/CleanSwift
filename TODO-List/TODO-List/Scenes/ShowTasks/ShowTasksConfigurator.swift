//
//  ShowTasksConfigurator.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 11/2/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ShowTasksViewController: ShowTasksPresenterOutput {
}

extension ShowTasksInteractor: ShowTasksViewControllerOutput {
}

extension ShowTasksPresenter: ShowTasksInteractorOutput {
}

extension MarkTaskAsDoneInteractor: MarkTaskAsDoneViewControllerOutput {
}

class ShowTasksConfigurator {
    // MARK: Object lifecycle
    
    static let singleton = ShowTasksConfigurator()
    
    // MARK: Configuration
    
    func configure(viewController: ShowTasksViewController) {
        let router = ShowTasksRouter()
        router.viewController = viewController
        
        let presenter = ShowTasksPresenter()
        presenter.output = viewController
        
        let interactor = ShowTasksInteractor()
        interactor.output = presenter
        
        let markTaskAsDoneInteractor = MarkTaskAsDoneInteractor()
        markTaskAsDoneInteractor.output = presenter
        
        viewController.output = interactor
        viewController.markTaskAsDoneOutput = markTaskAsDoneInteractor
        viewController.router = router
    }
}
