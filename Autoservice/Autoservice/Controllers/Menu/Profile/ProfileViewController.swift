//
//  ProfileViewController.swift
//  Autoservice
//
//  Created by Autoservice on 30/11/2017.
//  Copyright © 2017 Autoservice. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
	
	//MARK: - Properties
    
    private let _nameKey:String = "Name"
    private let _mailKey:String = "Mail"
    private let _phoneKey:String = "Phone"
    private let _dateKey:String = "Date"
    private let _timeKey:String = "Time"
    private let _autoKey:String = "Auto"
    private let _typeKey:String = "Type"
    private let _stateKey:String = "State"
    private let _loginKey:String = "Login"
    private let _errorKey:String = "Error"
    
    private var currentUserId:Int = Constants.INVALIDE_INT_VALUE
	
    @IBOutlet weak var ExitButtonOutlet: UIButton!
    @IBOutlet weak var SaveChangesButtonOutlet: UIButton!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var Login: UITextField!
    @IBOutlet weak var FullName: UITextField!
    
	// MARK: - Lifecycle Methods
	
    override func viewDidLoad() {
        super.viewDidLoad()
        InitialiseUI()
        GetCurrentUserID()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Initialise()
    }
	
    private func Initialise(){
        FetchCurrentUserData()
    }
    
    private func InitialiseUI(){
        ExitButtonOutlet.layer.cornerRadius = 5
        ExitButtonOutlet.layer.borderColor = UIColor.black.cgColor
        ExitButtonOutlet.layer.borderWidth = 0.5
        ExitButtonOutlet.layer.masksToBounds = true
        
        SaveChangesButtonOutlet.layer.cornerRadius = 5
        SaveChangesButtonOutlet.layer.borderColor = UIColor.black.cgColor
        SaveChangesButtonOutlet.layer.borderWidth = 0.5
        SaveChangesButtonOutlet.layer.masksToBounds = true
        
        addKeyboardHideHanlder()
    }
    
    private func GetCurrentUserID(){
        currentUserId =  UserDefaults.standard.integer(forKey: Constants.USER_ID_USER_DEFAULTS_KEY)
    }
    
    private func FetchCurrentUserData(){
        //TODO : CHECK SERVER CONNECT !!!!!!!!
        let userDataFromServer = RequestManager.getUserData(userID: currentUserId)
        if (userDataFromServer["Error"] as? String == "Error: calling request"){
            let alert = AlertManager.CreateDialog(inputTitle: "Ошибка подключения", inputMessage: "Проверьте подключение и повторите попытку", actionsDict: [ "Оффлайн режим" : {_ in },"Повторить попытку" : {_ ->Void in self.FetchCurrentUserData()}])
            present(alert, animated: true)
            return
        }
        if let userName = userDataFromServer[_nameKey] as? String , userDataFromServer[_nameKey] as! String != "null"{
            FullName.text = userName
        }
        if let userLogin = userDataFromServer[_loginKey] as? String , userDataFromServer[_loginKey] as! String != "null"{
            Login.text = userLogin
        }
        if let userPhoneNumber = userDataFromServer[_phoneKey] as? String , userDataFromServer[_phoneKey] as! String != "null"{
            Phone.text = userPhoneNumber
        }
        if let userEmail = userDataFromServer[_mailKey] as? String , userDataFromServer[_mailKey] as! String != "null"{
            Email.text = userEmail
        }
    }
	
	//MARK: - Actions
	
	@IBAction func SaveChanges(_ sender: Any) {
		let updResult = RequestManager.updateUserData(userID: currentUserId, userLogin: Login.text, userFullName: FullName.text, userEmail: Email.text, userPhone: Phone.text)
		let alertTitle = (updResult) ? "Успешно" : "Ошибка"
		let alertMessage = (updResult) ? "Данные обновлены" : "Неверные данные,данный логин уже занят, возможно даже вами"
		let alertView = AlertManager.CreateDialog(inputTitle: alertTitle, inputMessage: alertMessage, actionsDict: [ "OK" : {_ in }])
		present(alertView, animated: true)
	}
	
	@IBAction func ExitButton(_ sender: Any) {
		UserDefaults.standard.removeObject(forKey: Constants.USER_ID_USER_DEFAULTS_KEY)
		let autorizationStoryBoard =  UIStoryboard(name: "Authorization", bundle: nil)
		if let loginVC = autorizationStoryBoard.instantiateInitialViewController(){
			present(loginVC, animated: true)
		}
	}
}
