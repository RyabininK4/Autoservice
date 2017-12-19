//
//  AutoserviceUITests.swift
//  AutoserviceUITests
//
//  Created by Kirill Ryabinin on 07.11.2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import XCTest

class RegistrationTests: XCTestCase {
        
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
    
    func test_Valid_Data(){
        
        let app = XCUIApplication()
        let button = app.buttons["Зарегистрироваться"]
        button.tap()
        
        let element = app.otherElements.containing(.navigationBar, identifier:"Регистрация").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("TestingLogin")
        
        let textField2 = element.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.typeText("TestFio")
        
        let textField3 = element.children(matching: .textField).element(boundBy: 2)
        textField3.tap()
        textField3.typeText("testmail@mail.ru")
        
        let textField4 = element.children(matching: .textField).element(boundBy: 3)
        textField4.tap()
        textField4.typeText("+70000000001")
        
        let secureTextField = element.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("password")
        
        let switch2 = app.switches["1"]
        switch2.tap()
        button.tap()
        XCTAssert(app.staticTexts["Успешно"].exists)
    }
    
    func test_No_Password(){
        
        let app = XCUIApplication()
        let button = app.buttons["Зарегистрироваться"]
        button.tap()
        
        let element = app.otherElements.containing(.navigationBar, identifier:"Регистрация").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("TestingLogin")
        
        let textField2 = element.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.typeText("TestFio")
        
        let textField3 = element.children(matching: .textField).element(boundBy: 2)
        textField3.tap()
        textField3.typeText("testmail@mail.ru")
        
        let textField4 = element.children(matching: .textField).element(boundBy: 3)
        textField4.tap()
        textField4.typeText("+70000000001")

        
        let switch2 = app.switches["1"]
        switch2.tap()
        button.tap()
        XCTAssert(app.staticTexts["Неверные данные"].exists)
    }
    
    func test_No_Login(){
        
        let app = XCUIApplication()
        let button = app.buttons["Зарегистрироваться"]
        button.tap()
        
        let element = app.otherElements.containing(.navigationBar, identifier:"Регистрация").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        let textField2 = element.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.typeText("TestFio")
        
        let textField3 = element.children(matching: .textField).element(boundBy: 2)
        textField3.tap()
        textField3.typeText("testmail@mail.ru")
        
        let textField4 = element.children(matching: .textField).element(boundBy: 3)
        textField4.tap()
        textField4.typeText("+70000000001")
        
        let secureTextField = element.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("password")
        
        let switch2 = app.switches["1"]
        switch2.tap()
        button.tap()
        XCTAssert(app.staticTexts["Неверные данные"].exists)
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
