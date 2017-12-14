//
//  RecordData.swift
//  Autoservice
//
//  Created by артем on 30/11/2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import Foundation

public class RecordData{
    
    public var Id:Int 
    public var UserId:Int
    public var Date:String
    public var Duration:Int
    public var TimeIntervalIndex:Int
    public var Mark:String
    public var Model:String
    public var RepairType:String
    public var State:String
    public var RepairDuration:String
    public var RepairState:String
    
    public init(Id:Int = Constants.INVALIDE_INT_VALUE,UserId:Int = UserDefaults.standard.integer(forKey: Constants.USER_ID_USER_DEFAULTS_KEY),Date:String = String(),Duration:Int = Constants.INVALIDE_INT_VALUE,TimeIntervalIndex:Int = Constants.INVALIDE_INT_VALUE,Mark:String = String(),Model:String = String(),RepairType:String = String(),State:String = String(),RepairDuration:String = String(),RepairState:String = String()){
        self.Id = Id
        self.UserId = UserId
        self.Date = Date
        self.Duration = Duration
        self.TimeIntervalIndex = TimeIntervalIndex
        self.Mark = Mark
        self.Model = Model
        self.State = State
        self.RepairDuration = RepairDuration
        self.RepairState = RepairState
        self.RepairType = RepairType
    }
}
