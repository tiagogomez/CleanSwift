//
//  TestPListTests.swift
//  TestPListTests
//
//  Created by Santiago Gomez Giraldo on 11/8/18.
//  Copyright © 2018 Santiago Gomez Giraldo. All rights reserved.
//

import XCTest
@testable import TestPList

class TODO_ListTests: XCTestCase {
    
    var mockTasksList: [String]?
    var mockNewTasksList: [[String : Any]]?
    let task1: [String:Any] = ["task" : "First Task", "isDone" : false]
    let task2: [String:Any] = ["task" : "Second Task", "isDone" : true]
    let task3: [String:Any] = ["task" : "Third Task", "isDone" : false]
    
    override func setUp() {
        mockTasksList = ["First Task", "Second Task", "Third Task"]
        mockNewTasksList = [task1,task2, task3]
    }
    
    override func tearDown() {
        mockTasksList = nil
    }
    
    func testPListCreated() {
        let worker = PListWorker(name: "TestTaskList")
        let listCreated = worker.checkOrCreatePList(with: mockTasksList)
        XCTAssertTrue(listCreated, "The list does not exist")
    }
    
    // Refactor
    
    func testNewPListCreated() {
        let worker = PListWorker(name: "NewTestTaskList")
        let listCreated = worker.newCheckOrCreatePList(with: mockNewTasksList)
        XCTAssertTrue(listCreated, "The list does not exist")
    }
    
    func testNewGetPListData() {
        let worker = PListWorker(name: "NewTestTaskList")
        worker.newCheckOrCreatePList(with: mockNewTasksList)
        let tasksList: [[String : Any]] = worker.getNewPList()!
        XCTAssertNotNil(tasksList, "The List Should not be nil")
    }
    
    func testUpdateNewPListData() {
        let worker = PListWorker(name: "NewTestTaskList")
        let newTask: [String : Any] = ["task" : "NewTask", "isDone" : false]
        worker.setDataToNewPList(task: newTask)
        let tasksList: [[String : Any]] = worker.getNewPList()!
        let actualTask: String = tasksList.last?["task"] as! String
        XCTAssertEqual(actualTask, "NewTask")
    }
    
    func testNewRemoveDataFromPList() {
        let worker = PListWorker(name: "NewTestTaskList")
        worker.newCheckOrCreatePList(with: mockNewTasksList)
        let tasksToRemove = ["First Task", "Second Task"]
        worker.removeDataNew(tasks: tasksToRemove)
        let tasksList: [[String : Any]] = worker.getNewPList()!
        let actualTask: String = tasksList[0]["task"] as! String
        XCTAssertEqual(actualTask, "Third Task")
        
    }
}
