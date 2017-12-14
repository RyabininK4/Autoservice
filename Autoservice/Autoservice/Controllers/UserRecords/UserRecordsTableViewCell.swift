//
//  UserRecordsTableViewCell.swift
//  Autoservice
//
//  Created by Autoservice on 30/11/2017.
//  Copyright © 2017 Autoservice. All rights reserved.
//

import UIKit

class UserRecordsTableViewCell: UITableViewCell {
	
	//MARK: - Properties
	
	@IBOutlet weak var date : UILabel!
	@IBOutlet weak var time : UILabel!
	@IBOutlet weak var status : UILabel!
	@IBOutlet weak var desc : UILabel!
	
	public func SetData(recordData:RecordData){
		self.date.text = recordData.date
		self.time.text = Constants.TIME_INTERVALS_DICTIONARY[recordData.timeIntervalIndex]
		self.status.text = recordData.repairState
		self.desc.text = recordData.repairType
		SetStateColor(recordData.repairState)
	}
	
	private func SetStateColor(_ stateText:String){
		switch stateText {
		case Constants.REPAIR_STATE[0]:
			status.textColor = .red
		case Constants.REPAIR_STATE[1],
			 Constants.REPAIR_STATE[2]:
			status.textColor = .orange
		case Constants.REPAIR_STATE[3]:
			status.textColor = .green
		default:
			break
		}
	}
}
