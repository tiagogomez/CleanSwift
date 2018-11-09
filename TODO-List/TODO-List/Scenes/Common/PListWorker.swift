//
//  ShowTasksWorker.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 10/31/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

struct TaskModel {
    let taskText: String
    let taskState: Bool = false
}

enum PListWorkerError: Error {
    case theListCouldNotBeCreated
    case couldNotRetrieveAnyData
    case couldNotSaveTheData
    case couldNotDeleteTheData
}

class PListWorker {
    
    var plistURL : URL
    
    init(name: String) {
        let documentDirectoryURL =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        self.plistURL = documentDirectoryURL.appendingPathComponent("\(name).plist")
        }
    
    func checkOrCreatePList(with data: [[String : Any]]?) throws -> Bool? {
        let fileManager = FileManager.default
        if (!fileManager.fileExists(atPath: plistURL.path)){
            let toDoList = data ?? []
            try savePropertyList(toDoList)
            return true
        }
        return true
    }
    
    func getPList() throws -> [[String : Any]]? {
        let tasksList: [[String : Any]] = try loadPropertyList()
        return tasksList
    }
    
    func setDataToPList(task: String) throws {
        var tasksList: [[String : Any]] = try loadPropertyList()
        tasksList.append(["task" : task, "isDone": false])
        try savePropertyList(tasksList)
    }
    
    func changeDataState(tasksToMark: [String]) throws {
        do {
            var tasksList: [[String : Any]] = try loadPropertyList()
            for taskToMarkAsDone in tasksToMark {
                for i in 0 ..< tasksList.count {
                    let taskText = tasksList[i]["task"] as! String
                    if taskText == taskToMarkAsDone {
                        tasksList[i]["isDone"] = true
                    }
                }
//                if let taskToEdit = tasksList.first(where: { (task: [String : Any]) -> Bool in
//                    let actualTask = task["task"] as! String
//                    return (actualTask == taskToMarkAsDone)
//                }) {
//                    print ("encontró", taskToEdit)
//                    if let index = tasksList.index(of: taskToEdit){
//
//                    }
//                }
            }
            try savePropertyList(tasksList)
        } catch {
            print(error)
        }
    }
    
    func removeData(tasks: [String]) throws {
        do {
            var tasksList: [[String : Any]] = try loadPropertyList()
            for taskToRemove in tasks {
                tasksList = tasksList.filter { (task: [String : Any]) -> Bool in
                    let actualTask = task["task"] as! String
                    return (actualTask != taskToRemove)
                }
            }
            try savePropertyList(tasksList)
        } catch {
            print(error)
        }
    }
    
    private func savePropertyList(_ plist: Any) throws {
        let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
        try plistData.write(to: plistURL)
    }
    
    private func loadPropertyList() throws -> [[String : Any]] {
        let data = try Data(contentsOf: plistURL)
        guard let plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [[String : Any]] else {
            return [[String : Any]]()
        }
        return plist
    }
}
