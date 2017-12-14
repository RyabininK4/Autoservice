//
//  RepairTypeCell.swift
//  Autoservice
//
//  Created by артем on 01/12/2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import UIKit

class RepairTypeCell: UITableViewCell {

    @IBOutlet weak var RemontTypeLabel: UILabel!
    @IBOutlet weak var RemontTypeDescription: UILabel!
   
    public func SetData(remontDescription:String){
        RemontTypeDescription.text = remontDescription
    }

}
