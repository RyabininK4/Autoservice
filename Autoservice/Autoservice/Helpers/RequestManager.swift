//
//  RequestManager.swift
//  Autoservice
//
//  Created by Autoservice on 30/11/2017.
//  Copyright © 2017 Autoservice. All rights reserved.
//

import Foundation

class RequestManager {
	
	//Server
	private static let _serverScheme = "http"
	private static let _serverAddress:String = "192.168.1.66"
	private static let _serverPort:String = "8080"
	
	//Functions names
	private static let _registerFunc:String = "/register"
	private static let _loginServ:String = "/login"
	private static let _verifyServ:String = "/verServ"
	private static let _delServ:String = "/delServ"
	private static let _getServ:String = "/getServ"
	private static let _getUserData:String = "/getUserData"
	private static let _updUserData:String = "/updUserData"
	private static let _getAutoBrands:String = "/getAutoBrands"
	private static let _getAutoModels:String = "/getAutoModels"
	private static let _regServ:String = "/regServ"
	private static let _updServ:String = "/updServ"
	private static let _getAvailableIntervals:String = "/getAvailableIntervals"
	
	//Attributes names
	private static let _nameAttr:String = "name"
	private static let _mailAttr:String = "mail"
	private static let _phoneAttr:String = "phone"
	private static let _dateAttr:String = "date"
	private static let _timeAttr:String = "time"
	private static let _autoAttr:String = "auto"
	private static let _typeAttr:String = "type"
	private static let _stateAttr:String = "state"
	private static let _loginAttr:String = "login"
	private static let _passwordAttr:String = "password"
	private static let _idAttr:String = "id"
	private static let _brandAttr:String = "brand"
	private static let _userIdAttr:String = "userId"
	private static let _repairStateAttr:String = "repairState"
	private static let _repairDurationAttr:String = "repairDuration"
	private static let _durationAttr:String = "duration"
	
	private static let _idKey:String = "Id"
	private static let _userIdKey:String = "UserId"
	private static let _dateKey:String = "Date"
	private static let _timeKey:String = "Time"
	private static let _durationKey:String = "Duration"
	private static let _autoKey:String = "Auto"
	private static let _typeKey:String = "Type"
	private static let _stateKey:String = "State"
	private static let _repairDurationKey:String = "RepairDuration"
	private static let _repairStateKey:String = "RepairState"
	
	//Symbols Helpers
	private static let _beforeAttributesSymbol:String = "?"
	private static let _concatAttributesSymbol:String = "&"
	
	//Request errors
	private static let _errorPartOfErrorMessage = "Error"
	private static let _errorPartOfReRegister = "Already registered"
	private static let _callingRequestError:String = "Error: calling request"
	private static let _invalidReceivingDataError:String = "Error: did not receive data"
	private static let _converDataToJSONError:String = "Error: trying to convert data to JSON"
	private static let _gettingMsgFromJSONError:String = "Error:Could not get message from JSON"
	private static let _accoutExistingErrorPart:String = "not exists"
	private static let _wrongPasswordError:String = "Wrong password!"
	
	//Initialize
	private init() {}
	
	//Subclasses
	public class LoginResult{
		var LoginState : Enums.LoginState
		var userId:Int
		
		public init(inputLoginState:Enums.LoginState,inputUserId:Int = Constants.INVALIDE_INT_VALUE){
			LoginState = inputLoginState
			userId = inputUserId
		}
	}
	
	public class RegisterResult{
		var RegisterState:Enums.RegisterState
		var userId:Int
		
		public init(inputRegisterState:Enums.RegisterState,inputUserId:Int = Constants.INVALIDE_INT_VALUE){
			RegisterState = inputRegisterState
			userId = inputUserId
		}
	}
	
	//Public
	
	public static func registerUser(name:String,password:String,email:String,phoneNumber:String,login:String)->RegisterResult{
		
		var items:[URLQueryItem] = []
		items.append(URLQueryItem(name:_nameAttr, value: name))
		items.append(URLQueryItem(name:_passwordAttr, value: password))
		items.append(URLQueryItem(name:_loginAttr, value: login))
		items.append(URLQueryItem(name:_phoneAttr, value: phoneNumber))
		items.append(URLQueryItem(name:_mailAttr, value: email))
		
		let requestResult =  MakeRequest(_registerFunc,items)
		
		guard let requestMessage = requestResult["Id"] as? String else {
			print(_gettingMsgFromJSONError)
			return RegisterResult(inputRegisterState: .FailedToRegister)
		}
		if let requestError = requestResult["Error"] as? String {
			print(requestError)
			return RegisterResult(inputRegisterState: ((requestResult["Error"] as? String)?.contains(_errorPartOfReRegister))!
				? .AllreadyRegistred
				: .FailedToRegister)
		}
		
		if let userID = requestResult["Id"] as? String , let userIDValue = Int(userID) {
			return RegisterResult(inputRegisterState:.Success , inputUserId: userIDValue)
		}
		else {
			return RegisterResult(inputRegisterState: .FailedToRegister )
		}
		
	}
	
	public static func loginUser(login:String,password:String)->LoginResult{
		
		var items:[URLQueryItem] = []
		items.append(URLQueryItem(name:_passwordAttr, value: password))
		items.append(URLQueryItem(name:_loginAttr, value: login))
		
		let requestResult =  MakeRequest(_loginServ,items)
		
		if let requestError = requestResult["Error"] as? String {
			print(requestError)
			if requestError.contains(_accoutExistingErrorPart) ||
				requestError.contains(_wrongPasswordError){
				return LoginResult(inputLoginState: Enums.LoginState.FailedWithInvalideLogin, inputUserId: Constants.INVALIDE_INT_VALUE)
			}
			return LoginResult(inputLoginState: Enums.LoginState.FailedWithError, inputUserId: Constants.INVALIDE_INT_VALUE)
		}
		else{
			if let userID = requestResult["Id"] as? String , let userIDValue = Int(userID) {
				return LoginResult(inputLoginState: Enums.LoginState.Success , inputUserId: userIDValue)
			}
			else {
				return LoginResult(inputLoginState: Enums.LoginState.FailedWithError , inputUserId: Constants.INVALIDE_INT_VALUE)
			}
		}
	}
	
	public static func getUserData(userID:Int)->[String:Any]{
		var items:[URLQueryItem] = []
		items.append(URLQueryItem(name:_idAttr, value: String(userID)))
		return MakeRequest(_getUserData,items)
	}
	
	public static func updateUserData(userID:Int,userLogin:String?,
									  userFullName:String?,userEmail:String?,userPhone:String?,userPassword:String?=nil)->Bool{
		var items:[URLQueryItem] = []
		items.append(URLQueryItem(name:_idAttr, value: String(userID)))
		if(userLogin != nil && !(userLogin?.isEmpty)!) { items.append(URLQueryItem(name:_loginAttr, value: userLogin)) }
		if(userPassword != nil && !(userPassword?.isEmpty)!) { items.append(URLQueryItem(name:_passwordAttr, value: userPassword)) }
		if(userFullName != nil && !(userFullName?.isEmpty)!) { items.append(URLQueryItem(name:_nameAttr, value: userFullName)) }
		if(userEmail != nil && !(userEmail?.isEmpty)!) { items.append(URLQueryItem(name:_mailAttr, value: userEmail)) }
		if(userPhone != nil && !(userPhone?.isEmpty)!) { items.append(URLQueryItem(name:_phoneAttr, value: userPhone)) }
		
		
		let requestResult = MakeRequest(_updUserData,items)
		return (requestResult["Error"] as? String == nil)
	}
	
	public static func getAvailibleIntervals(_ date:String)->[Int]{
		var result:[Int] = []
		
		if let messages = MakeRequest(_getAvailableIntervals,[URLQueryItem(name:_dateAttr, value:date)])["Intervals"] as? String{
			for value in messages.components(separatedBy: ",") {
				if (Int(value) != nil){
					result.append(Int(value)!)
				}
			}
		}
		return result
	}
	
	public static func getAutoBrands()->[String]{
		var resultStringArray:[String] = []
		let messages = MakeRequest(_getAutoBrands, [])["Message"]
		if let test = messages as? String{
			resultStringArray = test.components(separatedBy: ",")
		}
		return resultStringArray
	}
	
	public static func getAutoModels(brand:String)->[String]{
		var resultStringArray:[String] = []
		let messages = MakeRequest(_getAutoModels,[URLQueryItem(name:_brandAttr, value: brand)])["Message"]
		if let test = messages as? String{
			resultStringArray = test.components(separatedBy: ",")
		}
		return resultStringArray
	}
	
	
	
	public static func createRecordOnServ(_ record:RecordData)->Bool{
		var query:[URLQueryItem] = []
		query.append(URLQueryItem(name: _userIdAttr, value: String(record.userId)))
		query.append(URLQueryItem(name: _dateAttr, value: String(record.date)))
		let stringValueFromRecord = Constants.TIME_INTERVALS_DICTIONARY[record.timeIntervalIndex]
		
		let startTime:String = stringValueFromRecord![0...4]
		query.append(URLQueryItem(name: _timeAttr, value: startTime))
		query.append(URLQueryItem(name: _autoAttr, value: record.mark + " " + record.model))
		query.append(URLQueryItem(name: _typeAttr, value: record.repairType))
		
		let messages = MakeRequest(_regServ,query)["Message"]
		
		return ((messages as? String) != nil)
	}
	
	public static func getRecordsFromServer(userId:Int = Constants.INVALIDE_INT_VALUE)->[RecordData]{
		var result:[RecordData] = []
		var query:[URLQueryItem] = []
		if (userId != Constants.INVALIDE_INT_VALUE){
			query.append(URLQueryItem(name: _userIdAttr, value: String(userId)))
		}
		let messages = MakeRequest(_getServ,query)
		if messages.count > 0{
			
			
			for iter in 1...messages.count
			{
				if let message = messages[String(iter)] as? [String:Any]{
					let record = RecordData()
					if let AutoValue = message["Auto"] as? String{
						record.mark = AutoValue
					}
					if let DateValue = message["Date"] as? String{
						record.date = DateValue
					}
					if let DurationValue = message["Duration"] as? Int{
						record.duration = DurationValue
					}
					print(message["Id"])
					if let IdValue = message["Id"] as? String{
						if Int(IdValue) != nil{
							record.id = Int(IdValue)!
						}
					}
					if let RepairDurationValue = message["RepairDuration"] as? String{
						record.repairDuration = RepairDurationValue
					}else {
						record.repairDuration = "Не подтверждён"
					}
					
					if let RepairStateValue = message["RepairState"] as? String{
						record.repairState = RepairStateValue
					} else {
						record.repairState = "Не подтверждён"
					}
					if let StateValue = message["State"] as? String{
						record.state = StateValue
					}
					if let TimeValue = message["Time"] as? String{
						if let startTimeIndex = Constants.REVERT_TIME_INTERVALS_DICTIONARY[TimeValue]{
							record.timeIntervalIndex = startTimeIndex
						}
					}
					if let TypeValue = message["Type"] as? String{
						record.repairType = TypeValue
					}
					if let UserIdValue = message["UserId"] as? String{
						if (Int(UserIdValue) != nil){
							record.userId = Int(UserIdValue)!
						}
					}
					result.append(record)
				}
			}
			
		}
		
		return result
	}
	
	public static func updateRecord(_ record:RecordData)->Bool{
		var updateQuery:[URLQueryItem] = []
		var verifyQuery:[URLQueryItem] = []
		
		let stringValueFromRecord = Constants.TIME_INTERVALS_DICTIONARY[record.timeIntervalIndex]
		let startTime:String = stringValueFromRecord![0...4]
		
		updateQuery.append(URLQueryItem(name: _typeAttr, value: String(record.repairType)))
		updateQuery.append(URLQueryItem(name: _stateAttr, value: String(record.state)))
		updateQuery.append(URLQueryItem(name: _idAttr, value: String(record.id)))
		updateQuery.append(URLQueryItem(name: _repairStateAttr, value: String(record.repairState)))
		updateQuery.append(URLQueryItem(name: _repairDurationAttr, value: String(record.repairDuration)))
		
		verifyQuery.append(URLQueryItem(name: _timeAttr, value: startTime))
		verifyQuery.append(URLQueryItem(name: _dateAttr, value: record.date))
		verifyQuery.append(URLQueryItem(name: _durationAttr, value: "00:30"))
		//        TODO REWoRK
		//        verifyQuery.append(URLQueryItem(name: _durationAttr, value: String(record.Duration)))
		verifyQuery.append(URLQueryItem(name: _idAttr, value: String(record.id)))
		
		let messagesByUpdate = MakeRequest(_updServ,updateQuery)["Message"]
		let messagesByVerify = MakeRequest(_verifyServ, verifyQuery)["Message"]
		//TODO:REWORK
		return ((messagesByUpdate as? String) != nil) && ((messagesByVerify as? String) != nil)
	}
	
	public static func delRecord(_ recordId:Int)->Bool{
		var updateQuery:[URLQueryItem] = []
		updateQuery.append(URLQueryItem(name: _idAttr, value: String(recordId)))
		let messagesByDeleteOperation = MakeRequest(_delServ, updateQuery)["Message"]
		return ((messagesByDeleteOperation as? String) != nil)
	}
	
	//Private
	private static func MakeRequest(_ path:String,_ queryItems:[URLQueryItem])->[String: Any]{
		let semaphore = DispatchSemaphore(value: 0)
		var messageResult:[String:Any] = ["Error":"Failed To Create request"]
		guard let request = CreateRequest(path, queryItems) else {
			print("Error: cannot connect to server,check is it available")
			return messageResult
		}
		InitializeConnection(urlRequest: request,completion: { answear in
			messageResult.removeValue(forKey: "Error")
			for item in answear{
				messageResult[item.key] = item.value
			}
			semaphore.signal()
		})
		semaphore.wait();
		return messageResult
	}
	
	private static func CreateRequest(_ path:String,_ queryItems:[URLQueryItem] )->URLRequest?{
		var urlComponents = URLComponents()
		urlComponents.scheme = _serverScheme
		urlComponents.host = _serverAddress
		urlComponents.port = Int(_serverPort)
		urlComponents.path = path
		urlComponents.queryItems = queryItems
		let resultUrl = urlComponents.url
		return URLRequest(url: resultUrl!,timeoutInterval:TimeInterval(2) )
	}
	
	private static func InitializeConnection(urlRequest:URLRequest,completion: @escaping (_ message: [String: Any]) -> ())  {
		
		let session = URLSession.shared
		
		let task = session.dataTask(with: urlRequest, completionHandler: {(data,urlResponse,error) ->Void in
			// check for any errors
			guard error == nil else {
				print(_callingRequestError)
				print(error!)
				completion(["Error":_callingRequestError])
				return
			}
			// make sure we got data
			guard let responseData = data else {
				print(_invalidReceivingDataError)
				completion(["Error":_invalidReceivingDataError])
				return
			}
			// parse the result as JSON, since that's what the API provides
			do {
				guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
					as? [String: Any] else {
						print(_converDataToJSONError)
						completion(["Error":_converDataToJSONError])
						return
				}
				// let's just print it to prove we can access it
				print("The message is : " + todo.description)
				completion(todo)
				
			} catch  {
				print(_converDataToJSONError)
				completion(["Error":_converDataToJSONError])
				return
			}
		})
		
		task.resume()
		
	}
}

extension String {
	subscript (bounds: CountableClosedRange<Int>) -> String {
		let start = index(startIndex, offsetBy: bounds.lowerBound)
		let end = index(startIndex, offsetBy: bounds.upperBound)
		return String(self[start...end])
	}
}
