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
    
    var mockTasksList: [String]?
    var mockResponse: ShowTasksResponse?
    
    override func setUp() {
        mockTasksList = ["First Task", "Second Task", "Third Task"]
        mockResponse = ShowTasksResponse(tasksList: mockTasksList!)
    }
    
    override func tearDown() {
        mockTasksList = nil
        mockResponse = nil
    }
    
    func testPListCreated() {
        let worker = PListWorker(name: "TestTaskList")
        let listCreated = worker.checkOrCreatePList(with: mockTasksList)
        XCTAssertTrue(listCreated, "The list does not exist")
    }
    
    // Refactor
    func testGetPListData() {
        let worker = PListWorker(name: "TestTaskList")
        worker.checkOrCreatePList(with: mockTasksList)
        let tasksList: [String] = worker.getPList()!
        XCTAssertNotNil(tasksList, "The List Should not be nil")
    }
    
    func testUpdatePListData() {
        let worker = PListWorker(name: "TestTaskList")
        worker.setDataToPList(task: "NewTask")
        let tasksList: [String] = worker.getPList()!
        XCTAssertEqual(tasksList.last, "NewTask")
    }
    
    func testTransformData() {
        let presenter = ShowTasksPresenter()
        let tasksList = presenter.transformDataToViewModel(data: mockResponse!)
        XCTAssertEqual(tasksList, mockTasksList, "Both lists should be the same")
    }
    
    func testRemoveDataFromPList() {
        let worker = PListWorker(name: "TestTaskList")
        worker.checkOrCreatePList(with: mockTasksList)
        let tasksToRemove = ["First Task", "Second Task"]
        worker.removeData(tasks: tasksToRemove)
        let tasksList: [String] = worker.getPList()!
        XCTAssertEqual(tasksList[0], "Third Task")
        
    }
}
