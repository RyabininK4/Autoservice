//
//  SignUpViewController.swift
//  Autoservice
//
//  Created by Kirill Ryabinin on 07.11.2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {
	
	//MARK: - Properties
	
	@IBOutlet weak var name : UITextField!
	@IBOutlet weak var email : UITextField!
	@IBOutlet weak var phone : UITextField!
	@IBOutlet weak var password : UITextField!
    @IBOutlet weak var AutoEnterSwitch: UISwitch!
    @IBOutlet weak var Login: UITextField!
    
    @IBAction func RegistrationActivity(_ sender: Any) {
        registration()
    }
    @IBOutlet weak var RegistrationButton: UIButton!
    //MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

		RegistrationButton.layer.cornerRadius = 5
		RegistrationButton.layer.borderColor = UIColor.black.cgColor
		RegistrationButton.layer.borderWidth = 0.5
		RegistrationButton.layer.masksToBounds = true
		
		addKeyboardHideHanlder()
    }

    private func registration(){
        if ((name.text?.isEmpty)! || (email.text?.isEmpty)! ||
            (phone.text?.isEmpty)! || (password.text?.isEmpty)! || (Login.text?.isEmpty)!){
            self.present(AlertManager.CreateDialog(inputTitle: "Неверные данные", inputMessage: "Заполните все поля", actionsDict: ["OK":{_ in}]), animated: true)
        }
        else{
            let userIDByRegistration = RequestManager.registerUser(name: name.text!, password: password.text!, email: email.text!, phoneNumber: phone.text!, login: Login.text!)
            switch(userIDByRegistration.RegisterState){
            case .Success:
                successRegistrationEnding(userIDByRegistration.userId)
            case .AllreadyRegistred:
                self.present(AlertManager.CreateDialog(inputTitle: "Неверные данные", inputMessage: "Введенный логин уже занят", actionsDict: ["OK":{_ in}]), animated: true)
            case .FailedToRegister:
                self.present(AlertManager.CreateDialog(inputTitle: "Неверные данные", inputMessage: "Проверьте корректность данных", actionsDict: ["OK":{_ in}]), animated: true)
            }
        }
    }
    
    private func successRegistrationEnding(_ userIDByRegistration:Int){
        func anything(alert: UIAlertAction!) {
            if (AutoEnterSwitch.isOn){
                UserDefaults.standard.set(userIDByRegistration, forKey: Constants.USER_ID_USER_DEFAULTS_KEY)
                let mainStoryBoard = UIStoryboard(name: "Menu", bundle: nil)
                if let homePage = mainStoryBoard.instantiateInitialViewController(){
                    self.present(homePage, animated:true)
                }
            }
            else{
                self.navigationController?.popViewController(animated: true)
            }
        }
        self.present(AlertManager.CreateDialog(inputTitle: "Успешно", inputMessage: "Регистрация прошла успешно", actionsDict: ["OK":anything]), animated: true)
        
    }
        
}

