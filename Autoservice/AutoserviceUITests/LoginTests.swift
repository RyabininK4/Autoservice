//
//  LoginTests.swift
//  AutoserviceUITests
//
//  Created by Simon Kulish on 13.12.17.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import XCTest

class LoginTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Invalid_Login(){
        
        let app = XCUIApplication()
        let element = app.otherElements.containing(.navigationBar, identifier:"Вход").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element
        textField.tap()

        textField.typeText("InvalidLogin")
        
        let secureTextField = element.children(matching: .secureTextField).element
        secureTextField.tap()

        secureTextField.typeText("123456")
        app.buttons["Войти"].tap()
        XCTAssert(app.staticTexts["Неверные данные"].exists)
        
    }
    
    func test_Invalid_Password(){
        let app = XCUIApplication()
        let element = app.otherElements.containing(.navigationBar, identifier:"Вход").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element
        textField.tap()
        
        textField.typeText("Test")
        
        let secureTextField = element.children(matching: .secureTextField).element
        secureTextField.tap()
        
        secureTextField.typeText("wrongpass")
        app.buttons["Войти"].tap()
        XCTAssert(app.staticTexts["Неверные данные"].exists)
    }
    
    func test_Valid_Inputs(){
        
        let app = XCUIApplication()
        let element = app.otherElements.containing(.navigationBar, identifier:"Вход").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element
        textField.tap()
        textField.typeText("Test")
        
        let secureTextField = element.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.tap()
        secureTextField.typeText("123456")
        app.buttons["Войти"].tap()
        XCTAssert(app.navigationBars["Создание"].exists)
        let button = app.tabBars.buttons["Профиль"]
        button.tap()
        app.buttons["Выход"].tap()
        
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
