//
//  PListWorker.swift
//  TestPList
//
//  Created by Santiago Gomez Giraldo on 11/8/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

struct TaskModel {
    let taskText: String
    let taskState: Bool = false
}

class PListWorker {
    
    var plistURL : URL
    
    init(name: String) {
        let documentDirectoryURL =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        self.plistURL = documentDirectoryURL.appendingPathComponent("\(name).plist")
    }
    
    func checkOrCreatePList(with data: [String]?) -> Bool {
        do {
            let fileManager = FileManager.default
            if (!fileManager.fileExists(atPath: plistURL.path)){
                let toDoList = data ?? []
                try savePropertyList(toDoList)
                return true
            }
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func newCheckOrCreatePList(with data: [[String : Any]]?) -> Bool {
        do {
            let fileManager = FileManager.default
            if (!fileManager.fileExists(atPath: plistURL.path)){
                let toDoList = data ?? []
                try savePropertyList(toDoList)
                return true
            }
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func getNewPList() -> [[String : Any]]? {
        do{
            let tasksList: [[String : Any]] = try loadPropertyList()
            return tasksList
        } catch {
            print(error)
            return nil
        }
    }
    
    func setDataToNewPList(task: [String : Any]){
        do {
            var tasksList: [[String : Any]] = try loadPropertyList()
            tasksList.append(task)
            try savePropertyList(tasksList)
        } catch {
            print(error)
        }
    }

    func removeDataNew(tasks: [String]) {
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

    
//    func getPList() -> [String]? {
//        do{
//            let tasksList: [String] = try loadPropertyList()
//            return tasksList
//        } catch {
//            print(error)
//            return nil
//        }
//    }
    
//    func setDataToPList(task: String){
//        do {
//            var tasksList: [String] = try loadPropertyList()
//            tasksList.append(task)
//            try savePropertyList(tasksList)
//        } catch {
//            print(error)
//        }
//    }
//
//    func removeData(tasks: [String]){
//                do {
//                    var tasksList: [String] = try loadPropertyList()
//                    for taskToRemove in tasks {
//                        tasksList = tasksList.filter { (task: String) -> Bool in
//                            return (task != taskToRemove)
//                        }
//                    }
//                    try savePropertyList(tasksList)
//                } catch {
//                    print(error)
//                }
//    }
    
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

