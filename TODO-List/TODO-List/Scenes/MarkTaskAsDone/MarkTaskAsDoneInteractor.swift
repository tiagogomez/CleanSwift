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
