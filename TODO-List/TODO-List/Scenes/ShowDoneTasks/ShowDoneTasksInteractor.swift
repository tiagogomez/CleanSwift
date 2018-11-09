//
//  ShowDoneTasksInteractor.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 11/9/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

protocol ShowDoneTasksInteractorInput {
    func requestDoneTasks(request: ShowDoneTasksRequest) throws
}

protocol ShowDoneTasksInteractorOutput {
    func presentTaskList(response: ShowDoneTasksResponse)
}

class ShowDoneTasksInteractor: ShowDoneTasksInteractorInput {
    
    var output: ShowDoneTasksInteractorOutput!
    var worker: PListWorker!
    
    func requestDoneTasks(request: ShowDoneTasksRequest) throws {
        worker = PListWorker(name: "TaskList")
        guard let _ = try worker.checkOrCreatePList(with: nil) else {
            throw PListWorkerError.theListCouldNotBeCreated
        }
        guard let tasksList: [TaskModel] = try worker.getPList() else {
            throw PListWorkerError.couldNotRetrieveAnyData
        }
        let newTaskList = filterDoneTasks(tasks: tasksList)
        let response = ShowDoneTasksResponse(tasksList: newTaskList)
        output.presentTaskList(response: response)
        
    }
    
    func filterDoneTasks(tasks: [TaskModel]) -> [TaskModel] {
        let filteredTasksList = tasks.filter { (task: TaskModel) -> Bool in
            return (task.taskState == true)
        }
        return filteredTasksList
    }
}
