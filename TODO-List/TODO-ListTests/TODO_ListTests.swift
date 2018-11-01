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
    var mockResponse: CreateTaskResponse?
    
    override func setUp() {
        mockTasksList = ["First Task", "Second Task"]
        mockResponse = CreateTaskResponse(tasksList: mockTasksList!)
    }
    
    override func tearDown() {
    }
    
    func testPListCreated() {
        let worker = PListWorker()
        let listCreated = worker.createPList()
        XCTAssertTrue(listCreated, "The list does not exist")
    }
    
    // Refactor
    func testGetPListData() {
        let worker = PListWorker()
        let tasksList: [String] = worker.getPList()!
        XCTAssertEqual(tasksList[2], "Holi", "")
    }
    
    func testTransformData() {
        let presenter = CreateTaskPresenter()
        let tasksList = presenter.transformDataToViewModel(data: mockResponse!)
        XCTAssertEqual(tasksList, mockTasksList, "Both lists shoul be the same")
    }
}
