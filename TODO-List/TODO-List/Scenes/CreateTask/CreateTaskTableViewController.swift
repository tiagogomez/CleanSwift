//
//  CreateTaskViewController.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 10/31/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

protocol CreateTaskViewControllerInput {
    func displayTaskList(viewModel: CreateTaskViewModel)
}

protocol CreateTaskViewControllerOutput {
    func storeTask(request: CreateTaskRequest)
}

class CreateTaskViewController: UITableViewController, CreateTaskViewControllerInput {
        
    var output: CreateTaskViewControllerOutput!
    var tasksList: [String] = []
    
    
    // MARK: Object lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        CreateTaskConfigurator.singleton.configure(viewController: self)
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTask()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.text = tasksList[indexPath.row]
        return cell
    }
    
    // MARK: Event handling
    func setTask() {
        let request = CreateTaskRequest()
        output.storeTask(request: request)
    }
    
    // MARK: Display logic
    func displayTaskList(viewModel: CreateTaskViewModel) {
        // NOTE: Display the result from the Presenter
        tasksList = viewModel.tasksList
        tableView.reloadData()
        print("list", tasksList)
    }
}

//        let fileManager = FileManager.default
//        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//        let path = documentDirectory.appending("/TaskList.plist")
//
//        if (!fileManager.fileExists(atPath: path)) {
//            let arrayContent: [String] = ["Hacer test", "hacer código"]
//            let plistContent = NSArray(array: arrayContent)
//            let success:Bool = plistContent.write(toFile: path, atomically: true)
//            if success {
//                print("file has been created!")
//                return true
//            }else{
//                print("unable to create the file")
//                return false
//            }
//        }else{
//            print("file already exist")
//            return true
//        }
