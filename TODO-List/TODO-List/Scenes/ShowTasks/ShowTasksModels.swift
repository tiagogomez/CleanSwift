//
//  ShowTasksModels.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 11/2/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

struct ShowTasksRequest {
}
//To Do Change Dictionary for an object
struct ShowTasksResponse {
    let tasksList: [TaskModel]
}

struct ShowTasksViewModel {
    let tasksList: [String]
}
