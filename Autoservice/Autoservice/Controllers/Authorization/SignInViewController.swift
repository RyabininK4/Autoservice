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
	
	//MARK: - Lifecycle methods

	override func viewDidLoad() {
		super.viewDidLoad()
		
		signIn.layer.cornerRadius = 5
		signIn.layer.borderColor = UIColor.black.cgColor
		signIn.layer.borderWidth = 0.5
		signIn.layer.masksToBounds = true
		
		addKeyboardHideHanlder()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

