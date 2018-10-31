//
//  CreateTaskTableViewController.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 10/31/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

protocol CreateTaskTableViewControllerInput {
    func displayTaskList(viewModel: CreateTaskViewModel)
}

protocol CreateTaskTableViewControllerOutput {
    func sendText(request: CreateTaskRequest)
}

class CreateTaskTableViewController: UITableViewController, CreateTaskTableViewControllerInput {
    
    var output: CreateTaskTableViewControllerOutput!

    // MARK: Object lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        CreateTaskConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getTextFromView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // MARK: Event handling
    func getTextFromView()
    {
        let request = CreateTaskRequest()
        output.sendText(request: request)
    }
    
    // MARK: Display logic
    func displayTaskList(viewModel: CreateTaskViewModel) {
        // NOTE: Display the result from the Presenter
    }

}
