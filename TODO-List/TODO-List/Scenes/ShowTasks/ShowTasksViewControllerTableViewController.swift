//
//  ShowTasksViewControllerTableViewController.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 11/2/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

protocol ShowTasksViewControllerInput {
    func displayTaskList(viewModel: ShowTasksViewModel)
}

protocol ShowTasksViewControllerOutput {
    func requestTask(request: ShowTasksRequest)
}

class ShowTasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ShowTasksViewControllerInput {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var output: ShowTasksViewControllerOutput!
    var tasksList: [String] = []
    @IBAction func presentCreateTaskVC(_ sender: Any) {
//        let createTaskViewController = CreateTaskViewController()
//        self.navigationController?.pushViewController(createTaskViewController, animated: true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ShowTasksConfigurator.singleton.configure(viewController: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        showTasks()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.text = tasksList[indexPath.row]
        return cell
    }
    
    func showTasks() {
        let request = ShowTasksRequest()
        output.requestTask(request: request)
    }
    
    func displayTaskList(viewModel: ShowTasksViewModel) {
        tasksList = viewModel.tasksList
        tableView.reloadData()
        print("list", tasksList)
    }
}
