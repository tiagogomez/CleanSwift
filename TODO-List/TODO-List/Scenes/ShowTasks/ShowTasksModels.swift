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

struct ShowTasksResponse {
    let tasksList: [[String : Any]]
}

struct ShowTasksViewModel {
    let tasksList: [String]
}
