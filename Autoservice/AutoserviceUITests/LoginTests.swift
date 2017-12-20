//
//  LoginTests.swift
//  AutoserviceUITests
//
//  Created by Simon Kulish on 13.12.17.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import XCTest

class LoginTests: XCTestCase {
        
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        super.setUp()
        app.launchArguments += ["UI-Testing"]
        app.launch()
    }
    
    override func tearDown() {
        app.launchArguments.removeAll()
        super.tearDown()
    }
    
    func test_Invalid_Login(){
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
    
    
}
