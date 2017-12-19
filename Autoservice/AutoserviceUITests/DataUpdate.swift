//
//  DataUpdate.swift
//  AutoserviceUITests
//
//  Created by Simon Kulish on 14.12.17.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import XCTest

class DataUpdate: XCTestCase {
        let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        app.launchArguments += ["UI-Testing"]
        app.launch()
    }
    
    override func tearDown() {
        app.launchArguments.removeAll()
        super.tearDown()
    }
    
    func test_Change_Mail(){
        
        let app = goToFirstPage()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 2)
        textField.tap()
        textField.typeText("new_mail@mail.ru")
        app.buttons["Сохранить изменения"].tap()
        XCTAssert(app.staticTexts["Успешно"].exists)
        app.alerts["Успешно"].buttons["OK"].tap()
        app.buttons["Выход"].tap()
    }
    
    func test_Cant_Change_Mail_To_Null(){
        
//        let app = goToFirstPage()
//        let tabBarsQuery = app.tabBars
//        let button = tabBarsQuery.buttons["Профиль"]
//
//        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
//        let textField2 = element2.children(matching: .textField).element(boundBy: 2)
//        let textFieldValue = textField2.value as! String
//        textField2.tap()
//
//        let textField3 = element2.children(matching: .textField).element(boundBy: 3)
//        textField3.tap()
//
//        app.buttons["Сохранить изменения"].tap()
//        app.alerts["Успешно"].buttons["OK"].tap()
//        tabBarsQuery.buttons["Добавить запись"].tap()
//        button.tap()
//        textField2.tap()
//
//        XCTAssertEqual(textField2.value as! String, textFieldValue)
//        app.buttons["Выход"].tap()
        
        let app = goToFirstPage()
        
        let tabBarsQuery = app.tabBars
        let button = tabBarsQuery.buttons["Профиль"]
        button.tap()
        
        let textField2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 2)
        textField2.tap()
        let expectedValue = textField2.value as! String
        app.buttons["Сохранить изменения"].tap()
        app.alerts["Успешно"].buttons["OK"].tap()
        tabBarsQuery.buttons["Добавить запись"].tap()
        button.tap()
        XCTAssertEqual(textField2.value as! String, expectedValue)
        app.buttons["Выход"].tap()
    }
    
    func test_Change_Phone(){
        let app = goToFirstPage()
        
        let textField2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 3)
        textField2.tap()
        textField2.typeText("79000000")
        app.buttons["Сохранить изменения"].tap()
        
        XCTAssert(app.staticTexts["Успешно"].exists)
        app.alerts["Успешно"].buttons["OK"].tap()
        app.buttons["Выход"].tap()
        
    }
    
    func test_Change_Name(){
        
        let app = goToFirstPage()
        app.tabBars.buttons["Профиль"].tap()
        
        let textField2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.typeText("new_fio")
        app.buttons["Сохранить изменения"].tap()
        XCTAssert(app.staticTexts["Успешно"].exists)
        app.alerts["Успешно"].buttons["OK"].tap()
        app.buttons["Выход"].tap()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func goToFirstPage()->XCUIApplication{
        
        let element = app.otherElements.containing(.navigationBar, identifier:"Вход").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element
        textField.tap()
        textField.typeText("Test")
        
        let secureTextField = element.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("123456")
        app.buttons["Войти"].tap()
        
        let tabBarsQuery = app.tabBars
        let button = tabBarsQuery.buttons["Профиль"]
        button.tap()
        return app
    }
    
}
