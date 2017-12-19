//
//  AutoserviceUITests.swift
//  AutoserviceUITests
//
//  Created by Kirill Ryabinin on 07.11.2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import XCTest

class RegistrationTests: XCTestCase {
    
    let app = XCUIApplication()
    
	override func setUp() {
		super.setUp()
        app.launchArguments += ["UI-Testing"]
        app.launch()
        app.buttons["Зарегистрироваться"].tap()
		continueAfterFailure = false
	}
    
	override func tearDown() {
        app.launchArguments.removeAll()
		super.tearDown()
	}
	
	func test_AllFieldsEmpty() {
        app.buttons["Зарегистрироваться"].tap()
		XCTAssert(app.staticTexts["Неверные данные"].exists)
	}
	
	func test_LoginEmpty() {
        let button = app.buttons["Зарегистрироваться"]
		let element = app.otherElements.containing(.navigationBar, identifier:"Регистрация").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
		let textField = element.children(matching: .textField).element(boundBy: 1)
		textField.tap()
		textField.typeText("Kirill")
		
		let textField2 = element.children(matching: .textField).element(boundBy: 2)
		textField2.tap()
		textField2.typeText("qwerty@gmail.com")
		
		let textField3 = element.children(matching: .textField).element(boundBy: 3)
		textField3.tap()
		textField3.typeText("89999999999")
		
		let secureTextField = element.children(matching: .secureTextField).element
		secureTextField.tap()
		secureTextField.typeText("123")
		button.tap()
		
		XCTAssert(app.staticTexts["Неверные данные"].exists)
		
	}
	
	func test_FIOEmpty() {
        let button = app.buttons["Зарегистрироваться"]
		let element = app.otherElements.containing(.navigationBar, identifier:"Регистрация").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
		let textField = element.children(matching: .textField).element(boundBy: 0)
		textField.tap()
		textField.typeText("Kirill")
		
		let textField2 = element.children(matching: .textField).element(boundBy: 2)
		textField2.tap()
		textField2.typeText("qwerty@gmail.com")
		
		let textField3 = element.children(matching: .textField).element(boundBy: 3)
		textField3.tap()
		textField3.typeText("89999999999")
		
		let secureTextField = element.children(matching: .secureTextField).element
		secureTextField.tap()
		secureTextField.typeText("123")
		button.tap()
		
		XCTAssert(app.staticTexts["Неверные данные"].exists)
	}
	
	func test_MailEmpty() {
        let button = app.buttons["Зарегистрироваться"]
		let element = app.otherElements.containing(.navigationBar, identifier:"Регистрация").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
		let textField = element.children(matching: .textField).element(boundBy: 0)
		textField.tap()
		textField.typeText("Kirill")
		
		let textField1 = element.children(matching: .textField).element(boundBy: 1)
		textField1.tap()
		textField1.typeText("Kirill")
		
		let textField3 = element.children(matching: .textField).element(boundBy: 3)
		textField3.tap()
		textField3.typeText("89999999999")
		
		let secureTextField = element.children(matching: .secureTextField).element
		secureTextField.tap()
		secureTextField.typeText("123")
		button.tap()
		
		XCTAssert(app.staticTexts["Неверные данные"].exists)
	}
	
	func test_PhoneEmpty() {
		let button = app.buttons["Зарегистрироваться"]
		let element = app.otherElements.containing(.navigationBar, identifier:"Регистрация").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
		let textField = element.children(matching: .textField).element(boundBy: 0)
		textField.tap()
		textField.typeText("Kirill")
		
		let textField1 = element.children(matching: .textField).element(boundBy: 1)
		textField1.tap()
		textField1.typeText("Kirill")
		
		let textField2 = element.children(matching: .textField).element(boundBy: 2)
		textField2.tap()
		textField2.typeText("qwerty@gmail.com")
		
		let secureTextField = element.children(matching: .secureTextField).element
		secureTextField.tap()
		secureTextField.typeText("123")
		button.tap()
		
		XCTAssert(app.staticTexts["Неверные данные"].exists)
	}
	
	func test_PasswordEmpty() {
		let button = app.buttons["Зарегистрироваться"]
		let element = app.otherElements.containing(.navigationBar, identifier:"Регистрация").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
		let textField = element.children(matching: .textField).element(boundBy: 0)
		textField.tap()
		textField.typeText("Kirill")
		
		let textField1 = element.children(matching: .textField).element(boundBy: 1)
		textField1.tap()
		textField1.typeText("Kirill")
		
		let textField2 = element.children(matching: .textField).element(boundBy: 2)
		textField2.tap()
		textField2.typeText("qwerty@gmail.com")
		
		let textField3 = element.children(matching: .textField).element(boundBy: 3)
		textField3.tap()
		textField3.typeText("89999999999")
		
		button.tap()
		
		XCTAssert(app.staticTexts["Неверные данные"].exists)
	}
	
	func test_NoEmptyFields() {
		let button = app.buttons["Зарегистрироваться"]
		let element = app.otherElements.containing(.navigationBar, identifier:"Регистрация").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
		let textField = element.children(matching: .textField).element(boundBy: 0)
		textField.tap()
		textField.typeText("Kirill")
		
		let textField1 = element.children(matching: .textField).element(boundBy: 1)
		textField1.tap()
		textField1.typeText("Kirill")
		
		let textField2 = element.children(matching: .textField).element(boundBy: 2)
		textField2.tap()
		textField2.typeText("qwerty@gmail.com")
		
		let textField3 = element.children(matching: .textField).element(boundBy: 3)
		textField3.tap()
		textField3.typeText("89999999999")
		
		let secureTextField = element.children(matching: .secureTextField).element
		secureTextField.tap()
		secureTextField.typeText("123")
		
		button.tap()
		
		XCTAssert(app.staticTexts["Успешно"].exists)
	}
    
    func test_NoEmptyFields_With_Enter(){
        let button = app.buttons["Зарегистрироваться"]
        
        let element = app.otherElements.containing(.navigationBar, identifier:"Регистрация").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        let timeInterval = Int(Date().timeIntervalSince1970)
        textField.typeText(String(timeInterval))
        
        let textField2 = element.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.typeText("artemsfsf")
        
        let textField3 = element.children(matching: .textField).element(boundBy: 2)
        textField3.tap()
        textField3.typeText("klufone@mail.ru")
        
        let textField4 = element.children(matching: .textField).element(boundBy: 3)
        textField4.tap()
        textField4.typeText("89202932365")
        
        let secureTextField = element.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("123")
        button.tap()
        app.alerts["Успешно"].buttons["OK"].tap()
        XCTAssert(app.navigationBars["Создание"].exists)
        app.tabBars.buttons["Профиль"].tap()
        app.buttons["Выход"].tap()
    }
    
    func test_NoEmptyFields_With_Enter_by_login(){
        let button = app.buttons["Зарегистрироваться"]
        let element = app.otherElements.containing(.navigationBar, identifier:"Регистрация").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        let timeInterval = Int(Date().timeIntervalSince1970)
        textField.typeText(String(timeInterval))
        
        
        let textField2 = element.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.typeText("artemsfsf")
        
        let textField3 = element.children(matching: .textField).element(boundBy: 2)
        textField3.tap()
        textField3.typeText("klufone@mail.ru")
        
        let textField4 = element.children(matching: .textField).element(boundBy: 3)
        textField4.tap()
        textField4.typeText("89202932365")
        
        let secureTextField = element.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("123")
        app.switches["1"].tap()
        button.tap()
        
        let loginElement = app.otherElements.containing(.navigationBar, identifier:"Вход").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
       
        let textFieldLogin = loginElement.children(matching: .textField).element
        textFieldLogin.tap()
        textFieldLogin.typeText(String(timeInterval))
        
        let passTextField = loginElement.children(matching: .secureTextField).element
        passTextField.tap()
        passTextField.typeText("123")
        app.buttons["Войти"].tap()
        XCTAssert(app.navigationBars["Создание"].exists)
        app.tabBars.buttons["Профиль"].tap()
        app.buttons["Выход"].tap()
    }
    
    
	
}
