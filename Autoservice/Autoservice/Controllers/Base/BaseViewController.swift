//
//  BaseViewController.swift
//  Autoservice
//
//  Created by Kirill Ryabinin on 07.11.2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
	
	var isFirstAppear = true
	
	// MARK: - Lifecycle Methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
        addKeyboardHideHanlder()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.isNavigationBarHidden = false
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		isFirstAppear = false
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: - Utils
	
	func disableAdjustmentContent(_ tableView: UITableView) {
		if #available(iOS 11.0, *) {
			tableView.contentInsetAdjustmentBehavior = .never
		} else {
			self.automaticallyAdjustsScrollViewInsets = false
		}
	}
	
	// MARK: - Actions
	
	func addKeyboardHideHanlder() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
	
	@objc func hideKeyboard(_ gesture: UITapGestureRecognizer) {
		
		let view = gesture.view
		let loc = gesture.location(in: view)
		let subview = view?.hitTest(loc, with: nil)
		
		if subview?.tag != 100 {
			view?.endEditing(true)
		}
	}
	
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}

