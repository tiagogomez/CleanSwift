//
//  MarkTaskAsDoneInteractor.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 11/7/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

protocol MarkTaskAsDoneInteractorInput {
    func removeTasks(request: MarkTaskAsDoneRequest) throws
}

class MarkTaskAsDoneInteractor: MarkTaskAsDoneInteractorInput {
    
    var output: ShowTasksInteractorOutput!
    var worker: PListWorker!
    
    func removeTasks(request: MarkTaskAsDoneRequest) throws {
        worker = PListWorker(name: "TaskList")
        try worker.changeDataState(tasksToMark: request.doneTasks)
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
