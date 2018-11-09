//
//  ShowDoneTasksViewController.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 11/9/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

protocol ShowDoneTasksViewControllerInput {
    func displayTaskList(viewModel: ShowDoneTasksViewModel)
}

protocol ShowDoneTasksViewControllerOutput {
    func requestTask(request: ShowDoneTasksRequest)
}

class ShowDoneTasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var output: ShowDoneTasksViewControllerOutput!
    var tasksList: [String] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ShowDoneTasksConfigurator.singleton.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView () {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TaskViewCell", bundle: nil), forCellReuseIdentifier: "TaskViewCell")
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskViewCell", for: indexPath) as! TaskViewCell
        cell.taskText.text = tasksList[indexPath.row]
        return cell
    }
}

extension ShowDoneTasksViewController: ShowDoneTasksViewControllerInput {
    
    func displayTaskList(viewModel: ShowDoneTasksViewModel) {
    }
}
