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

class CreateTaskViewController: UIViewController, CreateTaskViewControllerInput {
    
    @IBOutlet var popUp: UIView!
    @IBOutlet weak var taskField: UITextField!
    
    var output: CreateTaskViewControllerOutput!
    var router: CreateTaskRouter!
    
    @IBAction func buttonPressed(_ sender: Any) {
        if taskField.text != "" {
            setTask(text: taskField.text!)
            router.navigateToShowTasks()
        }
    }
    
    // MARK: Object lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        CreateTaskConfigurator.singleton.configure(viewController: self)
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        popUp.layer.cornerRadius = 20
    }
    
    // MARK: Event handling
    func setTask(text: String) {
        let request = CreateTaskRequest(task: text)
        output.storeTask(request: request)
    }
    
    // MARK: Display logic
    func displayTaskList(viewModel: CreateTaskViewModel) {
        // NOTE: Display the result from the Presenter
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
