//
//  RecordData.swift
//  Autoservice
//
//  Created by Autoservice on 30/11/2017.
//  Copyright © 2017 Autoservice. All rights reserved.
//

import Foundation

public class RecordData {
	
	public var id : Int
	public var userId : Int
	public var date : String
	public var duration : String
	public var timeIntervalIndex : Int
	public var mark:String
	public var model:String
	public var repairType:String
	public var state:String
	public var repairDuration:String
	public var repairState:String
	
	public init(id : Int = Constants.INVALIDE_INT_VALUE, userId : Int = UserDefaults.standard.integer(forKey: Constants.USER_ID_USER_DEFAULTS_KEY), date : String = String(), duration : String = String(), timeIntervalIndex : Int = Constants.INVALIDE_INT_VALUE, mark : String = String(), model : String = String(), repairType : String = String(), state : String = String(), repairDuration : String = String(), repairState : String = String()) {
		self.id = id
		self.userId = userId
		self.date = date
		self.duration = duration
		self.timeIntervalIndex = timeIntervalIndex
		self.mark = mark
		self.model = model
		self.state = state
		self.repairDuration = repairDuration
		self.repairState = repairState
		self.repairType = repairType
	}
}
