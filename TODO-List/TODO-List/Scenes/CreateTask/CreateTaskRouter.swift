//
//  CreateTaskRouter.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 11/6/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

protocol CreateTaskRouterInput {
    func navigateToShowTasks()
}

class CreateTaskRouter: CreateTaskRouterInput {
    
    weak var viewController: CreateTaskViewController!
    
    func navigateToShowTasks() {
//        viewController.dismiss(animated: true) {
//            // Nothing to do here.
//        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        viewController.present(controller, animated: true, completion: nil)
    }
}
