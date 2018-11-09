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
    var newmockTaskList: [TaskModel]?
    let newtask1 = TaskModel(taskText: "First Task")
    let newtask2 = TaskModel(taskText: "Second Task", taskState: true)
    let newtask3 = TaskModel(taskText: "Third Task")
    let task1: [String:Any] = ["task" : "First Task", "isDone" : false]
    let task2: [String:Any] = ["task" : "Second Task", "isDone" : true]
    let task3: [String:Any] = ["task" : "Third Task", "isDone" : false]
    var mockResponse: ShowTasksResponse?
    
    override func setUp() {
        mockTasksList = [task1,task2, task3]
        newmockTaskList = [newtask1, newtask2, newtask3]
        mockResponse = ShowTasksResponse(tasksList: mockTasksList!)
    }
    
    override func tearDown() {
        mockTasksList = nil
        mockResponse = nil
    }
    
    func testPListCreated() {
        let worker = PListWorker(name: "TestTaskList")
        do {
            let listCreated = try worker.checkOrCreatePList(with: newmockTaskList)
            XCTAssertTrue(listCreated!, "The list does not exist")
        }catch {
            print("Something Wrong Happened")
        }
    }
    
    // Refactor
    func testGetPListData() {
        let worker = PListWorker(name: "TestTaskList")
        do {
            _ = try worker.checkOrCreatePList(with: newmockTaskList)
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
    
    
    func testChangeDataFromPList() {
        let worker = PListWorker(name: "TestTaskList")
        do {
            _ = try worker.checkOrCreatePList(with: newmockTaskList)
            let tasksToMark = ["First Task", "Second Task"]
            _ = try worker.changeDataState(tasksToMark: tasksToMark)
            let tasksList: [[String : Any]] = try worker.getPList()!
            let task1State: Bool = tasksList[0]["isDone"] as! Bool
            let task2State: Bool = tasksList[1]["isDone"] as! Bool
            XCTAssertEqual(task1State, true)
            XCTAssertEqual(task2State, true)
        } catch {
            print("Something Wrong Happened")
        }
    }
    
    func testFilterDoneTasks() {
        let interactor = ShowDoneTasksInteractor()
        let worker = PListWorker(name: "TestDoneTaskList")
        do {
            _ = try worker.checkOrCreatePList(with: newmockTaskList)
            let tasksList: [[String : Any]] = try worker.getPList()!
            print("testing", tasksList)
            let newTaskList = interactor.filterDoneTasks(tasks: tasksList)
            print("testing", newTaskList)
        } catch {
            print("Something Wrong Happened")
        }
    }
    
    func testTransformTaskModelToDictionary() {
        let worker = PListWorker(name: "TestTransformDoneTaskList")
        var transformedList: [[String:Any]]?
        transformedList = worker.transformTaskModelToDictionary(tasksList: newmockTaskList!)
        print("transformed", transformedList, "expected", mockTasksList!)
    }
    
    func testTransformDictionaryYoTaskModel() {
        let worker = PListWorker(name: "TransformTestDoneTaskList")
        var transformedList: [TaskModel]?
        transformedList = worker.transformDictionaryToTaskModel(dictionaryList: mockTasksList!)
        print("transformed", transformedList, "expected", newmockTaskList!)
    }
}
