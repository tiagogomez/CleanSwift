//
//  CreateTaskPresenter.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 10/31/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

protocol CreateTaskPresenterInput {
    func presentTaskList(response: CreateTaskResponse)
}

protocol CreateTaskPresenterOutput: class {
    func displayTaskList(viewModel: CreateTaskViewModel)
}

class CreateTaskPresenter: CreateTaskPresenterInput {
    
    weak var output: CreateTaskPresenterOutput!
    
    // MARK: Presentation logic
    func presentTaskList(response: CreateTaskResponse) {
        
        // NOTE: Format the response from the Interactor and pass the result back to the View Controller
        let viewModel = CreateTaskViewModel()
        output.displayTaskList(viewModel: viewModel)
    }
    
}
