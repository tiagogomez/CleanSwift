//
//  ShowTasksViewController.swift
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
    func requestTask(request: ShowTasksRequest) throws
}

protocol MarkTaskAsDoneViewControllerOutput {
    func removeTasks(request: MarkTaskAsDoneRequest) throws
}

class ShowTasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var markAsDoneButton: UIButton!
    
    var output: ShowTasksViewControllerOutput!
    var markTaskAsDoneOutput: MarkTaskAsDoneViewControllerOutput!
    var router: ShowTasksRouter!
    
    var tasksList: [String] = []
    
    @IBAction func addTaskButtonPressed(_ sender: Any) {
        router.navigateToCreateTask()
    }
    
    @IBAction func markAsDoneButtonPressed(_ sender: Any) {
        if let indexForSelectedTasks = tableView.indexPathsForSelectedRows {
            var selectedTasks: [String] = []
            for index in indexForSelectedTasks {
                selectedTasks.append(tasksList[index.row])
            }
            let request = MarkTaskAsDoneRequest(doneTasks: selectedTasks)
            do{
                try markTaskAsDoneOutput.removeTasks(request: request)
                markAsDoneButton.isHidden = true
            } catch PListWorkerError.couldNotRetrieveAnyData {
                print("TheDataCouldNotBeRetrieved")
            } catch {
                
                print("Something Happened")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ShowTasksConfigurator.singleton.configure(viewController: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        showTasks()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskViewCell", for: indexPath) as! TaskViewCell
        cell.taskText.text = tasksList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        markAsDoneButton.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let indexForSelectedTasks = tableView.indexPathsForSelectedRows {
            if indexForSelectedTasks.isEmpty {
                markAsDoneButton.isHidden = true
            }
            return
        }
        markAsDoneButton.isHidden = true
    }
    
    func setupTableView () {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TaskViewCell", bundle: nil), forCellReuseIdentifier: "TaskViewCell")
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true
        markAsDoneButton.isHidden = true
    }
    
    func showTasks() {
        do{
            let request = ShowTasksRequest()
            try output.requestTask(request: request)
        } catch PListWorkerError.theListCouldNotBeCreated {
            print("TheListCouldNotBeCreated")
        } catch PListWorkerError.couldNotRetrieveAnyData{
            print("TheDataCouldNotBeRetrieved")
        } catch {
            print("Something Happened")
        }
    }
    
    private var messageSubView: UIView = UIView()
    private var messageLabel: UILabel = UILabel()
    
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

extension ShowTasksViewController : ShowTasksViewControllerInput {
    
    func displayTaskList(viewModel: ShowTasksViewModel) {
        tasksList = viewModel.tasksList
        tableView.reloadData()
        if tasksList.isEmpty {
            showSuggestion()
        }
    }
}
