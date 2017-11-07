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
	@IBOutlet weak var login : UITextField!
	@IBOutlet weak var phone : UITextField!
	@IBOutlet weak var password : UITextField!
	@IBOutlet weak var signUp : UIButton!
	
	//MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

		signUp.layer.cornerRadius = 5
		signUp.layer.borderColor = UIColor.black.cgColor
		signUp.layer.borderWidth = 0.5
		signUp.layer.masksToBounds = true
		
		addKeyboardHideHanlder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
