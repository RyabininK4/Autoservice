//
//  UserData.swift
//  Autoservice
//
//  Created by Autoservice on 30/11/2017.
//  Copyright © 2017 Autoservice. All rights reserved.
//

import Foundation

public class UserData{
	
	private let _userId : Int
	
	public var _login : String
	public var _fullName : String
	public var _email : String
	public var _phone : String
	public var _role : Enums.UserRole
	
	public init( login : String, fullName : String, email : String, phone : String, userId : Int, userRole : Enums.UserRole = .User) {
		_login = login
		_fullName = fullName
		_email = email
		_phone = phone
		_userId = userId
		_role = userRole
	}
	
	public init(){
		_login = String()
		_fullName = String()
		_email = String()
		_phone = String()
		_userId = Constants.INVALIDE_INT_VALUE
		_role = .User
	}
	
	public func GetUserId()->Int{
		return _userId
	}
}
