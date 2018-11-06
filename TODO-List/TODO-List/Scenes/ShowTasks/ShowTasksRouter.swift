//
//  ShowTasksRouter.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 11/6/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

protocol ShowTasksRouterInput {
    func navigateToCreateTask()
}

class ShowTasksRouter: ShowTasksRouterInput {
    
    weak var viewController: ShowTasksViewController!
    
    func navigateToCreateTask() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CreateTaskViewController")
        viewController.present(controller, animated: true, completion: nil)
    }
}
