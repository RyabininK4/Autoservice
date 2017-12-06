//
//  SignInViewController.swift
//  Autoservice
//
//  Created by Kirill Ryabinin on 07.11.2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController {
	
	//MARK: - Properties
	
	@IBOutlet weak var login : UITextField!
	@IBOutlet weak var password : UITextField!
	@IBOutlet weak var signIn : UIButton!
    
    @IBAction func SignInAction(_ sender: Any) {
        if ((login.text?.isEmpty)! || (password.text?.isEmpty)!)
        {
            let actionsDictionary:Dictionary<String,(UIAlertAction)->Void> = [ "OK" : {_ in }]
            let alertDialog = AlertManager.CreateDialog(inputTitle: "Неверно заполнена форма", inputMessage: "Введите логин и пароль", actionsDict: actionsDictionary)
            self.present(alertDialog, animated: true, completion: nil)
        }
        else{
            let requestResultByLogin = RequestManager.loginUser(login: login.text!, password: password.text!)
            
            if (requestResultByLogin.LoginState == Enums.LoginState.Success){
                UserDefaults.standard.set(requestResultByLogin.userId, forKey: Constants.USER_ID_USER_DEFAULTS_KEY)
                let mainStoryBoard = UIStoryboard(name: "Menu", bundle: nil)
                if let homePage = mainStoryBoard.instantiateInitialViewController(){
                    self.present(homePage, animated:true)
                }
            }
            else{
                var title:String = String()
                var message:String = String()
                switch(requestResultByLogin.LoginState){
                case(.FailedWithInvalideLogin):
                    title = "Неверные данные"
                    message = "Проверьте логин и пароль"
                    
                case(.FailedWithError):
                    title = "Ошибка соединения"
                    message = "Проверьте доступ к серверу"
                default:
                    break
                }
                let actionsDictionary:Dictionary<String,(UIAlertAction)->Void> = [ "OK" : {_ in }]
                let alertDialog = AlertManager.CreateDialog(inputTitle: title, inputMessage: message, actionsDict: actionsDictionary)
                self.present(alertDialog, animated: true, completion: nil)
            }
        }
        
    }
    
	
	//MARK: - Lifecycle methods

	override func viewDidLoad() {
		super.viewDidLoad()
        InitializeUI()
        Initialize()
	}

    private func InitializeUI(){
        
        signIn.layer.cornerRadius = 5
        signIn.layer.borderColor = UIColor.black.cgColor
        signIn.layer.borderWidth = 0.5
        signIn.layer.masksToBounds = true
        addKeyboardHideHanlder()
    }
    
    private func Initialize() -> Void {
        
    }
    
	
}

