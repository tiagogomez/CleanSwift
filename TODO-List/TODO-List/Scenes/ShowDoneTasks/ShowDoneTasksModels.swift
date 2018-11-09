//
//  ShowDoneTasksModels.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 11/9/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

struct ShowDoneTasksRequest {
}

//To Do Change Dictionary for an object
struct ShowDoneTasksResponse {
    let tasksList: [[String : Any]]
}

struct ShowDoneTasksViewModel {
    let tasksList: [String]
}
