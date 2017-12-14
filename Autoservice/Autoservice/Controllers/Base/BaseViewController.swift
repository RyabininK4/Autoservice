//
//  BaseViewController.swift
//  Autoservice
//
//  Created by Autoservice on 30/11/2017.
//  Copyright © 2017 Autoservice. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
	
	//MARK: - Properties
	
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
	
	func addBackButton() {
		let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
		button.setTitle("Назад", for: .normal)
		button.tintColor = UIColor.white
		button.addTarget(self, action: #selector(back(_:)), for: .touchUpInside)
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
	}
	
	@objc func back(_ sender: Any) {
		_ = navigationController?.popViewController(animated: true)
	}
	
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}

