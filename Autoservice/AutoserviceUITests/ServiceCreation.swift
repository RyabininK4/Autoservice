//
//  ServiceCreation.swift
//  AutoserviceUITests
//
//  Created by Simon Kulish on 14.12.17.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import XCTest

class ServiceCreation: XCTestCase {
    
        let app = XCUIApplication()
    override func setUp() {
        super.setUp()
        app.launchArguments += ["UI-Testing"]
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        app.launchArguments.removeAll()
        super.tearDown()
    }
    
    func test_Can_Create_Service(){
        
        let app = XCUIApplication()
        let element = app.otherElements.containing(.navigationBar, identifier:"Вход").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element
        textField.tap()
        textField.typeText("artem")
        
        let secureTextField = element.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("123")
        app.buttons["Войти"].tap()
        app.buttons["plus"].tap()
        let cells = app.tables.cells
        let cell0 = cells.element(boundBy: 0)
        let cell1 = cells.element(boundBy: 1)
        let cell2 = cells.element(boundBy: 2)
        let cell3 = cells.element(boundBy: 3)
        let cell4 = cells.element(boundBy: 4)
        cell0.tap()
//        app.tables.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: app.windows.firstMatch.frame.width, dy: app.windows.firstMatch.frame.height)).tap()
//        cell1.
//        app.tables.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: cell1.frame.midX, dy: cell1.frame.midY)).tap()
        app.tables.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: app.windows.firstMatch.frame.width - 10, dy: app.windows.firstMatch.frame.height - 222)).tap()
//        cell2.tap()
//        app.tables.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: app.windows.firstMatch.frame.width, dy: app.windows.firstMatch.frame.height)).tap()
//        cell3.tap()
//        app.tables.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: app.windows.firstMatch.frame.width, dy: app.windows.firstMatch.frame.height)).tap()
//        cell4.tap()
//        app.tables.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: app.windows.firstMatch.frame.width, dy: app.windows.firstMatch.frame.height)).tap()
//

    }

    func testExample() {
        
        let app = XCUIApplication()
        app.buttons["plus"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element.tap()
        
    }
    
}
