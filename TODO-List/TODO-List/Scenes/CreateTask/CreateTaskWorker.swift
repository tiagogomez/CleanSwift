//
//  CreateTaskWorker.swift
//  TODO-List
//
//  Created by Santiago Gomez Giraldo on 10/31/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import UIKit

class PListWorker {
    
    var plistURL : URL {
        let documentDirectoryURL =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return documentDirectoryURL.appendingPathComponent("TaskList.plist")
    }

    func createPList() -> Bool {
        do {
            let toDoList = ["Hacer algo", "Hacer otra cosa", "Holi"]
            try savePropertyList(toDoList)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func getPList() -> [String]? {
        do{
            let tasksList: [String] = try loadPropertyList()
            return tasksList
        } catch {
            print(error)
            return nil
        }
    }
        
    private func savePropertyList(_ plist: Any) throws {
        let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
        try plistData.write(to: plistURL)
    }
    
    private func loadPropertyList() throws -> [String] {
        let data = try Data(contentsOf: plistURL)
        guard let plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String] else {
            return [String]()
        }
        return plist
    }
}
