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
        continueAfterFailure = false
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
        cells.element(boundBy: 2).tap()
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        //      TODO:REMAKE
    }
    
    func testExample() {
        
    }
    
}
