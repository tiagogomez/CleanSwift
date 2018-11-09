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
        
        let task1: [String:Any] = ["task" : "First Task", "isDone" : false]
        let task2: [String:Any] = ["task" : "Second Task", "isDone" : true]
        let task3: [String:Any] = ["task" : "Third Task", "isDone" : false]
        let mockTasksList = [task1,task2, task3]
        
        worker = PListWorker(name: "TaskList")
        guard let _ = try worker.checkOrCreatePList(with: mockTasksList) else {
            throw PListWorkerError.theListCouldNotBeCreated
        }
        guard let tasksList: [[String : Any]] = try worker.getPList() else {
            throw PListWorkerError.couldNotRetrieveAnyData
        }
        let newTaskList = filterPendingTasks(tasks: tasksList)
        let response = ShowTasksResponse(tasksList: newTaskList)
        output.presentTaskList(response: response)
    }
    
    func filterPendingTasks(tasks: [[String : Any]]) -> [[String : Any]] {
        let filteredTasksList = tasks.filter { (task: [String : Any]) -> Bool in
            let taskState = task["isDone"] as! Bool
            return (taskState == false)
        }
        return filteredTasksList
    }
}
