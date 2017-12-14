//
//  Enums.swift
//  Autoservice
//
//  Created by Autoservice on 30/11/2017.
//  Copyright © 2017 Autoservice. All rights reserved.
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
	
	public enum CellInMangerEdit:Int{
		case Date = 0
		case Time = 1
		case Duration = 2
		case RepairStatus = 3
		case FinalDate = 4
		case RepairType = 5
	}
	
	public enum AddingRecordPagePickerStyle:Int{
		case Time = 1
		case Mark = 2
		case Model = 3
	}
	
	public enum ManagerEditPageDatePickerStyle:Int{
		case StartDate = 1
		case FinalDate = 2
	}
	
	public enum ManagerEditPagePickerStyle:Int{
		case Time = 1
		case State = 2
		case Duration = 3
	}
	
	public enum PickerType{
		case Date
		case Value
	}
}
