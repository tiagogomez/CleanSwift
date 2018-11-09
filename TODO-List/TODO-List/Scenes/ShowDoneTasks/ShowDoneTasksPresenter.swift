//
//  ShowDoneTasksPresenter.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 11/9/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

protocol ShowDoneTasksPresenterInput {
    func presentTaskList(response: ShowDoneTasksResponse)
}

protocol ShowDoneTasksPresenterOutput: class {
    func displayTaskList(viewModel: ShowDoneTasksViewModel)
}

class ShowDoneTasksPresenter: ShowDoneTasksPresenterInput {
    
    var output:ShowDoneTasksPresenterOutput!
    
    func presentTaskList(response: ShowDoneTasksResponse) {
    }
}
