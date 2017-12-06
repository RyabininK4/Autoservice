//
//  AppDelegate.swift
//  Autoservice
//
//  Created by Kirill Ryabinin on 07.11.2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if UserDefaults.standard.integer(forKey: Constants.USER_ID_USER_DEFAULTS_KEY) == 0 {
            let autorizationStoryBoard =  UIStoryboard(name: "Authorization", bundle: nil)
            let signInVC = autorizationStoryBoard.instantiateViewController(withIdentifier: "SignInNavigationController")
            self.window?.rootViewController = signInVC
            self.window?.makeKeyAndVisible()
        }
        else
        {
            let mainStoryBoard = UIStoryboard(name: "Menu", bundle: nil)
            let homeVC = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController")
            self.window!.rootViewController = homeVC
            self.window?.makeKeyAndVisible()
        }
		return true
	}

}

