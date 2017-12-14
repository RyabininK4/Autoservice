//
//  BaseTableViewController.swift
//  Autoservice
//
//  Created by Kirill Ryabinin on 14.12.2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
		
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

}
