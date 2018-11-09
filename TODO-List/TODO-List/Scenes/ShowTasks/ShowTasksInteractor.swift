//
//  ShowTasksInteractor.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 11/2/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

protocol ShowTasksInteractorInput {
    func requestTask(request: ShowTasksRequest) throws
}

protocol ShowTasksInteractorOutput {
    func presentTaskList(response: ShowTasksResponse)
}

class ShowTasksInteractor: ShowTasksInteractorInput {
    
    var output: ShowTasksInteractorOutput!
    var worker: PListWorker!
    
    func requestTask(request: ShowTasksRequest) throws {
        
        let task1 = TaskModel(taskText: "First Task")
        let task2 = TaskModel(taskText: "Second Task", taskState: true)
        let task3 = TaskModel(taskText: "Third Task")
        let mockTasksList = [task1,task2, task3]
        
        worker = PListWorker(name: "TaskList")
        guard let _ = try worker.checkOrCreatePList(with: mockTasksList) else {
            throw PListWorkerError.theListCouldNotBeCreated
        }
        guard let tasksList: [TaskModel] = try worker.getPList() else {
            throw PListWorkerError.couldNotRetrieveAnyData
        }
        let newTaskList = filterPendingTasks(tasks: tasksList)
        let response = ShowTasksResponse(tasksList: newTaskList)
        output.presentTaskList(response: response)
    }
    
    func filterPendingTasks(tasks: [TaskModel]) -> [TaskModel] {
        let filteredTasksList = tasks.filter { (task: TaskModel) -> Bool in
            return (task.taskState == false)
        }
        return filteredTasksList
    }
}
