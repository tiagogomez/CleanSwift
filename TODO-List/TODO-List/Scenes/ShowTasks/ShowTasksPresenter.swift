//
//  ShowTasksPresenter.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 11/2/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

protocol ShowTasksPresenterInput {
    func presentTaskList(response: ShowTasksResponse)
}

protocol ShowTasksPresenterOutput: class {
    func displayTaskList(viewModel: ShowTasksViewModel)
}

class ShowTasksPresenter: ShowTasksPresenterInput {
    
    weak var output: ShowTasksPresenterOutput!

    func presentTaskList(response: ShowTasksResponse) {
        
        let tasksList = transformDataToViewModel(data: response)
        let viewModel = ShowTasksViewModel(tasksList: tasksList)
        output.displayTaskList(viewModel: viewModel)
    }
    
    func transformDataToViewModel(data: ShowTasksResponse) -> [String] {
        var transformedData: [String]?
        transformedData = data.tasksList.map { (task: TaskModel) -> String in
            return task.taskText
        }
        return transformedData ?? []
    }
}
