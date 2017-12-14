//
//  RepairTypeDetailViewController.swift
//  Autoservice
//
//  Created by Autoservice on 30/11/2017.
//  Copyright © 2017 Autoservice. All rights reserved.
//

import UIKit

class RepairTypeDetailViewController: BaseViewController,UITextViewDelegate {
	
	//MARK: - Properties
	
	@IBOutlet weak var DescriptionTextEditOutlet: UITextView!
	
	private var _record : RecordData = RecordData()
	
	// MARK: - Lifecycle Methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		Initialise()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		addBackButton()
	}
	
	public func SetRecord(_ record :RecordData){
		_record = record
	}
	
	private func Initialise(){
		DescriptionTextEditOutlet.text = _record.repairType
		DescriptionTextEditOutlet.delegate = self
		DescriptionTextEditOutlet.layer.cornerRadius = 5
		DescriptionTextEditOutlet.layer.borderColor = UIColor.black.cgColor
		DescriptionTextEditOutlet.layer.borderWidth = 0.5
		DescriptionTextEditOutlet.layer.masksToBounds = true
		addKeyboardHideHanlder()
	}
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		SelectStartTextIfItExist()
	}
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		let newString = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
		_record.repairType = newString
		return true
	}
	
	private func SelectStartTextIfItExist(){
		if (DescriptionTextEditOutlet.text == Constants.RECORD_TYPE_DEFAULT_VALUE )
		{
			DispatchQueue.main.async {
				self.DescriptionTextEditOutlet.selectAll(nil)
			}
		}
	}
}
