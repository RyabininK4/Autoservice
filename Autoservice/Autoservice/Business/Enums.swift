//
//  Enums.swift
//  Autoservice
//
//  Created by артем on 30/11/2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import Foundation
public class Enums{
	
	public enum UserRole{
		case Admin
		case Manager
		case User
	}
	
	public enum RepairState{
		case NotStarted
		case InProgress
		case Finished
	}
	
	public enum LoginState{
		case Success
		case FailedWithError
		case FailedWithInvalideLogin
	}
	
	public enum RegisterState{
		case Success
		case AllreadyRegistred
		case FailedToRegister
	}
	
	public enum CellInAddingRecord:Int{
		case Date = 0
		case Time = 1
		case Mark = 2
		case Model = 3
		case RepairType = 4
	}
	
	public enum PickerType{
		case Date
		case Value
	}
}
