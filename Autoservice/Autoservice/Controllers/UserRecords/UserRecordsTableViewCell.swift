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
	@IBOutlet weak var desc : UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
