//
//  CreateTaskInteractor.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 10/31/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

protocol CreateTaskInteractorInput {
    func storeTask(request: CreateTaskRequest)
}

protocol CreateTaskInteractorOutput {
    func presentTaskList(response: CreateTaskResponse)
}

class CreateTaskInteractor: CreateTaskInteractorInput {
    
    var output: CreateTaskInteractorOutput!
    var worker: PListWorker!
    
    // MARK: Business logic
    func storeTask(request: CreateTaskRequest) {
        // NOTE: Create some Worker to do the work
        
        worker = PListWorker()
        worker.createPList()
        let tasksList: [String] = worker.getPList()!
        
        // NOTE: Pass the result to the Presenter
        
        let response = CreateTaskResponse(tasksList: tasksList)
        output.presentTaskList(response: response)
    }
    
}
