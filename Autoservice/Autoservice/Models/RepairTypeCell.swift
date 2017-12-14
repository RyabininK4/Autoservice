//
//  RepairTypeCell.swift
//  Autoservice
//
//  Created by Autoservice on 30/11/2017.
//  Copyright © 2017 Autoservice. All rights reserved.
//

import UIKit

class RepairTypeCell: UITableViewCell {
	
	//MARK: - Properties
	
	@IBOutlet weak var RemontTypeLabel: UILabel!
	@IBOutlet weak var RemontTypeDescription: UILabel!
	
	public func SetData(remontDescription:String){
		RemontTypeDescription.text = remontDescription
	}
	
}
