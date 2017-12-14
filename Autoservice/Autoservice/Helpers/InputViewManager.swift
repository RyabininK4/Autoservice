//
//  InputViewManager.swift
//  Autoservice
//
//  Created by Autoservice on 30/11/2017.
//  Copyright © 2017 Autoservice. All rights reserved.
//

import Foundation
import UIKit

public class InputViewManager{
	
	private static let NAV_BAR_ITEM_HEIGHT:CGFloat = 44
	
	public static func InitializeToolBar(view:UIView,toolBarButtons:[UIBarButtonItem])->UIToolbar{
		let _toolBar = UIToolbar()
		_toolBar.barStyle = .default
		_toolBar.isTranslucent = true
		_toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
		_toolBar.sizeToFit()
		
		// Adding Button ToolBar
		_toolBar.setItems(toolBarButtons, animated: true)
		_toolBar.isUserInteractionEnabled = true
		_toolBar.frame = CGRect(x:0,y:view.frame.height - 200 - _toolBar.frame.height - NAV_BAR_ITEM_HEIGHT,
								width:view.frame.width,height:_toolBar.frame.height)
		_toolBar.isHidden = true
		view.addSubview(_toolBar)
		return _toolBar
	}
	
	public static func InitializeValuePicker(view:UIView)->UIPickerView{
		let _pickerView = UIPickerView()
		_pickerView.backgroundColor = UIColor.white
		_pickerView.frame = CGRect(x: 0, y: view.frame.height - 200 - NAV_BAR_ITEM_HEIGHT, width: view.frame.width, height: 200)
		_pickerView.isHidden = true
		view.addSubview(_pickerView)
		return _pickerView
	}
	
	public static func InitializeDatePicker(view:UIView)->UIDatePicker{
		var datePicker = UIDatePicker(frame:CGRect(x: 0, y:  view.frame.height - 200 - NAV_BAR_ITEM_HEIGHT, width: view.frame.size.width, height: 200))
		datePicker.backgroundColor = UIColor.white
		datePicker.datePickerMode = .date
		datePicker.isHidden = true
		datePicker.minimumDate = Date()
		datePicker.maximumDate = Calendar.current.date(byAdding: .month, value: 3, to: Date())
		view.addSubview(datePicker)
		return datePicker
	}
}
