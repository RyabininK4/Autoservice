//
//  DataUpdate.swift
//  AutoserviceUITests
//
//  Created by Simon Kulish on 14.12.17.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import XCTest

class DataUpdate: XCTestCase {
        
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
    
    func test_Change_Mail(){
        
        let app = XCUIApplication()
        let element = app.otherElements.containing(.navigationBar, identifier:"Вход").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .textField).element.typeText("Test")
        
        let secureTextField = element.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("123456")
        app.buttons["Войти"].tap()
        
        let button = app.tabBars.buttons["Профиль"]
        button.tap()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 2)
        textField.tap()
        textField.typeText("new_mail@mail.ru")
        app.buttons["Сохраить изменения"].tap()
        XCTAssert(app.staticTexts["Успешно"].exists)
        
    }
    
    func test_Cant_Change_Mail_To_Null(){
        
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
        
        let tabBarsQuery = app.tabBars
        let button = tabBarsQuery.buttons["Профиль"]
        button.tap()
        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField2 = element2.children(matching: .textField).element(boundBy: 2)
        textField2.tap()
        
        let textField3 = element2.children(matching: .textField).element(boundBy: 3)
        textField3.tap()
        textField3.tap()
        app.buttons["Сохраить изменения"].tap()
        app.alerts["Успешно"].buttons["OK"].tap()
        tabBarsQuery.buttons["Добавить запись"].tap()
        button.tap()
        button.tap()
        textField2.tap()
        
        XCTAssertEqual(textField2.value as! String, "testmail")
    }
    
    func test_Change_Phone(){
        
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
        app.tabBars.buttons["Профиль"].tap()
        
        let textField2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 3)
        textField2.tap()
        textField2.typeText("79000000")
        app.buttons["Сохраить изменения"].tap()
        
        XCTAssert(app.staticTexts["Успешно"].exists)
    }
    
    func test_Change_Name(){
        
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
        app.tabBars.buttons["Профиль"].tap()
        
        let textField2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.typeText("new_fio")
        app.buttons["Сохраить изменения"].tap()
        XCTAssert(app.staticTexts["Успешно"].exists)
        
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
