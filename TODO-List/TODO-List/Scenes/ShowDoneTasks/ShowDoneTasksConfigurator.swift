//
//  ShowDoneTasksConfigurator.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 11/9/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ShowDoneTasksViewController: ShowDoneTasksPresenterOutput {
}

extension ShowDoneTasksInteractor: ShowDoneTasksViewControllerOutput {
}

extension ShowDoneTasksPresenter: ShowDoneTasksInteractorOutput {
}



class ShowDoneTasksConfigurator {
    
    static let singleton = ShowDoneTasksConfigurator()
    
    func configure(viewController: ShowDoneTasksViewController) {
        
        let presenter = ShowDoneTasksPresenter()
        presenter.output = viewController
        
        let interactor = ShowDoneTasksInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
    }
}
