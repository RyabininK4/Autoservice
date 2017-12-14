//
//  UserRecordsTableViewCell.swift
//  Autoservice
//
//  Created by Kirill Ryabinin on 06.12.2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import UIKit

class UserRecordsTableViewCell: UITableViewCell {
	
	@IBOutlet weak var date : UILabel!
	@IBOutlet weak var time : UILabel!
	@IBOutlet weak var status : UILabel!
	@IBOutlet weak var desc : UILabel!

    public func SetData(recordData:RecordData){
        self.date.text = recordData.Date
        self.time.text = Constants.TIME_INTERVALS_DICTIONARY[recordData.TimeIntervalIndex]
        self.status.text = recordData.RepairState
        self.desc.text = recordData.RepairType
        SetStateColor(recordData.RepairState)
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
