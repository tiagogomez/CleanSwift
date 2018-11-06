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
    
    var messageSubView: UIView = UIView()
    var messageLabel: UILabel = UILabel()

    var output: ShowTasksViewControllerOutput!
    var router: ShowTasksRouter!
    
    var tasksList: [String] = []
    
    @IBAction func addTaskButtonPressed(_ sender: Any) {
        router.navigateToCreateTask()
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
        if tasksList.isEmpty {
            showSuggestion()
        }
    }
    
    private func showSuggestion() {
        messageSubView.layer.cornerRadius = 20
        messageSubView.backgroundColor = UIColor .gray
        messageLabel.text = "You don´t have any task yet, Add a new task"
        messageSubView.addSubview(messageLabel)
        self.view.addSubview(messageSubView)
        messageSubView.translatesAutoresizingMaskIntoConstraints = false
        messageSubView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        messageSubView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        messageSubView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        messageSubView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.sizeToFit()
        messageLabel.textAlignment = .center
        messageLabel.centerYAnchor.constraint(equalTo: messageSubView.centerYAnchor, constant: 0).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: messageSubView.centerXAnchor, constant: 0).isActive = true
    }
}
