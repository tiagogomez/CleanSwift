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
        worker = PListWorker(name: "TaskList")
        guard let _ = try worker.checkOrCreatePList(with: nil) else {
            throw PListWorkerError.theListCouldNotBeCreated
        }
        guard let tasksList: [[String : Any]] = try worker.getPList() else {
            throw PListWorkerError.couldNotRetrieveAnyData
        }
        let response = ShowTasksResponse(tasksList: tasksList)
        output.presentTaskList(response: response)
    }
}
