//
//  TODO_ListTests.swift
//  TODO-ListTests
//
//  Created by Santiago Gomez Giraldo on 10/31/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import XCTest
@testable import TODO_List

class TODO_ListTests: XCTestCase {
    
    var mockTasksList: [[String : Any]]?
    let task1: [String:Any] = ["task" : "First Task", "isDone" : false]
    let task2: [String:Any] = ["task" : "Second Task", "isDone" : true]
    let task3: [String:Any] = ["task" : "Third Task", "isDone" : false]
    var mockResponse: ShowTasksResponse?
    
    override func setUp() {
        mockTasksList = [task1,task2, task3]
        mockResponse = ShowTasksResponse(tasksList: mockTasksList!)
    }
    
    override func tearDown() {
        mockTasksList = nil
        mockResponse = nil
    }
    
    func testPListCreated() {
        let worker = PListWorker(name: "TestTaskList")
        do {
            let listCreated = try worker.checkOrCreatePList(with: mockTasksList)
            XCTAssertTrue(listCreated!, "The list does not exist")
        }catch {
            print("Something Wrong Happened")
        }
    }
    
    // Refactor
    func testGetPListData() {
        let worker = PListWorker(name: "TestTaskList")
        do {
            _ = try worker.checkOrCreatePList(with: mockTasksList)
            let tasksList: [[String : Any]] = try worker.getPList()!
            XCTAssertNotNil(tasksList, "The List Should not be nil")
        } catch {
            print("Something Wrong Happened")
        }
    }
    
    func testUpdatePListData() {
        let worker = PListWorker(name: "TestTaskList")
        let newTask: String = "NewTask"
        do {
            try worker.setDataToPList(task: newTask)
            let tasksList: [[String : Any]] = try worker.getPList()!
            let actualTask: String = tasksList.last?["task"] as! String
            XCTAssertEqual(actualTask, "NewTask")
        } catch {
            print("Something Wrong Happened")
        }
    }
    
    func testTransformData() {
        let presenter = ShowTasksPresenter()
        let expectedValue = ["First Task", "Second Task", "Third Task"]
        let tasksListViewModel = presenter.transformDataToViewModel(data: mockResponse!)
        XCTAssertEqual(tasksListViewModel, expectedValue, "Both lists should be the same")
    }
    
    func testRemoveDataFromPList() {
        let worker = PListWorker(name: "TestTaskList")
        do {
            _ = try worker.checkOrCreatePList(with: mockTasksList)
            let tasksToRemove = ["First Task", "Second Task"]
            _ = try worker.removeData(tasks: tasksToRemove)
            let tasksList: [[String : Any]] = try worker.getPList()!
            let actualTask: String = tasksList[0]["task"] as! String
            XCTAssertEqual(actualTask, "Third Task")
        } catch {
            print("Something Wrong Happened")
        }
    }
}
