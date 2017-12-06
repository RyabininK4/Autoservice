//
//  Constants.swift
//  Autoservice
//
//  Created by артем on 29/11/2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import Foundation

public class Constants{
    private init(){}
    
    public static let USER_ID_USER_DEFAULTS_KEY:String = "userID"
    public static let INVALIDE_INT_VALUE:Int = -1
    public static let RECORD_TYPE_DEFAULT_VALUE = "Введите здесь примечания к ремонту"
    
    public static let TIME_INTERVALS_DICTIONARY:[Int:String] =
        [  0: "08:00-08:30",  1: "08:30-09:00",
           2: "09:00-09:30",  3: "09:30-10:00",
           4: "10:00-10:30",  5: "10:30-11:00",
           6: "11:00-11:30",  7: "11:30-12:00",
           8: "12:00-12:30",  9: "12:30-13:00",
           10: "13:00-13:30", 11: "13:30-14:00",
           12: "14:00-14:30", 13: "14:30-15:00",
           14: "15:00-15:30", 15: "15:30-16:00",
           16: "16:00-16:30", 17: "16:30-17:00",
           18: "17:00-17:30", 19: "17:30-18:00",
           20: "18:00-18:30", 21: "18:30-19:00",
           22: "19:00-19:30", 23: "19:30-20:00",
           24: "20:00-20:30"]
    
}
