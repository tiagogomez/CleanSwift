//
//  ShowTasksInteractor.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 11/2/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

protocol ShowTasksInteractorInput {
    func requestTask(request: ShowTasksRequest)
}

protocol ShowTasksInteractorOutput {
    func presentTaskList(response: ShowTasksResponse)
}

class ShowTasksInteractor: ShowTasksInteractorInput {
    
    var output: ShowTasksInteractorOutput!
    var worker: PListWorker!
    
    func requestTask(request: ShowTasksRequest) {
        worker = PListWorker(name: "TaskList")
        let listExist = worker.checkOrCreatePList(with: nil)
        if listExist {
            let tasksList: [[String : Any]] = worker.getPList()!
            let response = ShowTasksResponse(tasksList: tasksList)
            output.presentTaskList(response: response)
        }
    }
}
