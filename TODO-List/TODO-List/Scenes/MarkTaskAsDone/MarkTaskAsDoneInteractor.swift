//
//  MarkTaskAsDoneInteractor.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 11/7/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

protocol MarkTaskAsDoneInteractorInput {
    func removeTasks(request: MarkTaskAsDoneRequest)
}

class MarkTaskAsDoneInteractor: MarkTaskAsDoneInteractorInput {
    
    var output: ShowTasksInteractorOutput!
    var worker: PListWorker!
    
    func removeTasks(request: MarkTaskAsDoneRequest) {
        worker = PListWorker(name: "TaskList")
        worker.removeData(tasks: request.doneTasks)
        let tasksList: [[String : Any]] = worker.getPList()!
        let response = ShowTasksResponse(tasksList: tasksList)
        output.presentTaskList(response: response)
    }
}
