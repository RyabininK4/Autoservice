//
//  AlertManager.swift
//  Autoservice
//
//  Created by артем on 28/11/2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import Foundation
import UIKit

public class AlertManager{

    private static let indicatorSize:CGFloat = 100
    public static func CreateDialog(inputTitle:String,inputMessage:String,actionsDict:Dictionary<String, (UIAlertAction) -> Void>)-> UIAlertController
    {
        let alertController = UIAlertController(title:inputTitle, message: inputMessage, preferredStyle: .alert)
        
        for alert in actionsDict {
            alertController.addAction(UIAlertAction(title:alert.key,style: .default,handler:alert.value))
        }
        
        return alertController
    }

}
