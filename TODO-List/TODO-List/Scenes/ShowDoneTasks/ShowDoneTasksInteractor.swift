//
//  ShowDoneTasksInteractor.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 11/9/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

protocol ShowDoneTasksInteractorInput {
    func requestTask(request: ShowDoneTasksRequest)
}

protocol ShowDoneTasksInteractorOutput {
    func presentTaskList(response: ShowDoneTasksResponse)
}

class ShowDoneTasksInteractor: ShowDoneTasksInteractorInput {
    
    var output: ShowDoneTasksInteractorOutput!
    
    func requestTask(request: ShowDoneTasksRequest) {
    }
}
