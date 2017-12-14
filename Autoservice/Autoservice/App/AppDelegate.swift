//
//  AppDelegate.swift
//  Autoservice
//
//  Created by Autoservice on 30/11/2017.
//  Copyright © 2017 Autoservice. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		self.window = UIWindow(frame: UIScreen.main.bounds)
		
		if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
			let alert = AlertManager.CreateDialog(inputTitle: "Ошибка входа", inputMessage: "Зайдите в систему", actionsDict: ["OK": {_ in }])
			var startVC:UIViewController?
			switch(shortcutItem.type){
			case "com.autoservice.main.createrecord":
				startVC = (IsLoggedUser() ? GetCreatePageViewController() : GetSignInViewController() )
			case "com.autoservice.main.showrecords":
				startVC = (IsLoggedUser() ? GetUserRecordsViewController() : GetSignInViewController() )
			case "com.autoservice.main.gotoprofile":
				startVC = (IsLoggedUser() ? GetProfileViewController() : GetSignInViewController() )
			default:
				break
			}
			if (startVC != nil){
				SetInitialViewController(startVC!)
				if (!IsLoggedUser()){
					startVC?.present(alert, animated: true)
				}
			}
		}
		else {
			SetInitialViewController((IsLoggedUser() ? GetCreatePageViewController() : GetSignInViewController() ))
		}
		return true
	}
	
	private func GetCreatePageViewController()->UIViewController{
		let mainStoryBoard = UIStoryboard(name: "Menu", bundle: nil)
		return mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController")
	}
	
	private func GetSignInViewController()->UIViewController{
		let mainStoryBoard = UIStoryboard(name: "Authorization", bundle: nil)
		return mainStoryBoard.instantiateViewController(withIdentifier: "SignInNavigationController")
	}
	
	private func GetProfileViewController()->UIViewController{
		let mainStoryBoard = UIStoryboard(name: "Menu", bundle: nil)
		let vc = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController")
		if let tabBar = vc as? UITabBarController{
			tabBar.selectedIndex = 2
			return tabBar
		}
		return mainStoryBoard.instantiateInitialViewController()!
	}
	
	private func GetUserRecordsViewController()->UIViewController{
		let mainStoryBoard = UIStoryboard(name: "Menu", bundle: nil)
		let vc = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController")
		if let tabBar = vc as? UITabBarController{
			tabBar.selectedIndex = 1
			return tabBar
		}
		return mainStoryBoard.instantiateInitialViewController()!
	}
	
	private func IsLoggedUser()->Bool{
		return (UserDefaults.standard.integer(forKey: Constants.USER_ID_USER_DEFAULTS_KEY) != 0
			&& UserDefaults.standard.integer(forKey: Constants.USER_ID_USER_DEFAULTS_KEY) > 0)
	}
	
	private func SetInitialViewController(_ vc:UIViewController){
		self.window!.rootViewController = vc
		self.window?.makeKeyAndVisible()
	}
}
