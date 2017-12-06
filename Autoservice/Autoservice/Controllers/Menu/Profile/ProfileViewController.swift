//
//  ProfileViewController.swift
//  Autoservice
//
//  Created by артем on 29/11/2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    //Variables and attributes
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
    
    //Outlets and Actions
    @IBOutlet weak var ExitButtonOutlet: UIButton!
    @IBOutlet weak var SaveChangesButtonOutlet: UIButton!
    
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Phone: UITextField!
    
    @IBAction func SaveChanges(_ sender: Any) {
        let updResult = RequestManager.updateUserData(userID: currentUserId, userLogin: Login.text, userFullName: FullName.text, userEmail: Email.text, userPhone: Phone.text)
        let alertTitle = (updResult) ? "Успешно" : "Ошибка"
        let alertMessage = (updResult) ? "Данные обновлены" : "Неверные данные,данный логин уже занят, возможно даже вами"
        let alertView = AlertManager.CreateDialog(inputTitle: alertTitle, inputMessage: alertMessage, actionsDict: [ "OK" : {_ in }])
        present(alertView, animated: true)
    }
    
    @IBOutlet weak var Login: UITextField!
    @IBOutlet weak var FullName: UITextField!
    
    @IBAction func ExitButton(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: Constants.USER_ID_USER_DEFAULTS_KEY)
        let autorizationStoryBoard =  UIStoryboard(name: "Authorization", bundle: nil)
        if let loginVC = autorizationStoryBoard.instantiateInitialViewController(){
            present(loginVC, animated: true)
        }
    }
    
    //Lifecycles methods
    override func viewDidLoad() {
        super.viewDidLoad()
        InitialiseUI()
        GetCurrentUserID()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Initialise()
    }
    
    
    //Private
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
}
