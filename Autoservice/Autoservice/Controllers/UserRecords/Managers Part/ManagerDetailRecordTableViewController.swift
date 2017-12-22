//
//  ManagerDetailRecordTableViewController.swift
//  Autoservice
//
//  Created by Autoservice on 30/11/2017.
//  Copyright © 2017 Autoservice. All rights reserved.
//

import UIKit

class ManagerDetailRecordTableViewController: BaseTableViewController,UIPickerViewDelegate,UIPickerViewDataSource {
	
	//MARK: - Properties
	
	@IBOutlet weak var recordTableView: UITableView!
	@IBOutlet weak var PhoneBarButtonItem: UIBarButtonItem!
	
	private var _record:RecordData = RecordData()
	private var _selectedTypeOfPicker:Enums.ManagerEditPagePickerStyle?
	private var _selectedTypeOfDatePicker:Enums.ManagerEditPageDatePickerStyle?
	private var _toolBar = UIToolbar()
	private var _pickerView = UIPickerView()
	private var _datePicker = UIDatePicker()
	private var _availibleIntervals:[Int] = []
    private var _availibleIntevalsTitles:[String] = []
    private var _availibleIntevalsWithOutDescription:[String] = []
    private var _areDatesAvailible = true
	
	// MARK: - Lifecycle Methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		InitializeToolBar()
		InitializeDatePicker()
		InitializeValuePicker()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		recordTableView.reloadData()
		addBackButton()
	}
	
	private func InitializeDatePicker(){
		_datePicker = InputViewManager.InitializeDatePicker(view: self.view)
	}
	
	private func InitializeValuePicker(){
		_pickerView = InputViewManager.InitializeValuePicker(view: self.view)
	}
	
	private func InitializeToolBar(){
		let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddingRepairRecordTableViewController.doneClick))
		let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AddingRepairRecordTableViewController.cancelClick))
		_toolBar = InputViewManager.InitializeToolBar(view:self.view,toolBarButtons:[cancelButton, spaceButton, doneButton])
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}
	
	//MARK: - TableView
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cellIdentifier:String = String()
		var detailCellInfo:String = String()
		var isCellAvailible = true
		let areStartDateAndDurationAvailible:Bool = (_record.repairState == Constants.REPAIR_STATE.first)
		switch indexPath.row {
		case Enums.CellInMangerEdit.Date.rawValue:
			isCellAvailible = areStartDateAndDurationAvailible
			cellIdentifier = "RecordDate"
			detailCellInfo = _record.date
		case Enums.CellInMangerEdit.Time.rawValue:
			isCellAvailible = areStartDateAndDurationAvailible
			cellIdentifier = "RecordTime"
            if let timeIntervalValue = Constants.TIME_INTERVALS_DICTIONARY[_record.timeIntervalIndex]{
                detailCellInfo = timeIntervalValue[0...4]
            }
			
		case Enums.CellInMangerEdit.RepairStatus.rawValue:
			cellIdentifier = "RepairStatusCell"
			detailCellInfo = _record.repairState
		case Enums.CellInMangerEdit.FinalDate.rawValue:
			cellIdentifier = "FinalDate"
			detailCellInfo = _record.repairDuration
		case Enums.CellInMangerEdit.RepairType.rawValue:
			cellIdentifier = "RepairType"
		case Enums.CellInMangerEdit.Duration.rawValue:
			cellIdentifier = "DurationTime"
            var temp = String()
            if (_record.duration.count >= 5){
                temp.append(contentsOf: _record.duration[0...1])
                temp.append(contentsOf: "ч")
                temp.append(contentsOf: _record.duration[3...4])
                temp.append(contentsOf: "мин")
            }
            
			detailCellInfo = temp
            
		default:
			break
		}
		if indexPath.row == Enums.CellInMangerEdit.RepairType.rawValue {
			if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath) as? RepairTypeCell{
				cell.SetData(remontDescription: _record.repairType)
				return cell
			}
		}
		else {
			let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath)
			cell.detailTextLabel?.text = detailCellInfo
			cell.textLabel?.textColor = (isCellAvailible) ? UIColor.black : UIColor.lightGray
			cell.detailTextLabel?.textColor = (isCellAvailible) ? UIColor.black : UIColor.lightGray
			return cell
			
		}
		return UITableViewCell()
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let alertTitle = "Внимание"
		let alertMessage = "Для статуса '" + _record.repairState + "' данное поле неизменяемо"
		let alert = AlertManager.CreateDialog(inputTitle: alertTitle, inputMessage: alertMessage, actionsDict: ["ОК":{_ in }])
        let datesAlert = AlertManager.CreateDialog(inputTitle: "Внимание", inputMessage: "Свободные промежутки отсутсвуют", actionsDict: ["OK":{_ in}])
		let areStartDateAndDurationAvailible:Bool = (_record.repairState == Constants.REPAIR_STATE.first)
		switch indexPath.row {
		case Enums.CellInMangerEdit.Date.rawValue:
            _selectedTypeOfPicker = Enums.ManagerEditPagePickerStyle.Date
			_selectedTypeOfDatePicker = .StartDate
            
			(areStartDateAndDurationAvailible) ? doPicker(.Date) : present(alert,animated: true)
		case Enums.CellInMangerEdit.Time.rawValue:
			_selectedTypeOfPicker = Enums.ManagerEditPagePickerStyle.Time
			_availibleIntervals = RequestManager.getAvailibleIntervals(_record.date)
            (_areDatesAvailible)
                ? ((areStartDateAndDurationAvailible) ? doPicker(.Value) : present(alert,animated: true))
                : present(datesAlert,animated: true)
		case Enums.CellInMangerEdit.RepairStatus.rawValue:
			_selectedTypeOfPicker = Enums.ManagerEditPagePickerStyle.State
			doPicker(.Value)
        case Enums.CellInMangerEdit.Duration.rawValue:
            _availibleIntevalsTitles = getAvailibleDurationsForStartTimeForTitle()
            _selectedTypeOfPicker = Enums.ManagerEditPagePickerStyle.Duration
            (_areDatesAvailible) ? doPicker(.Value) : present(datesAlert,animated: true)
		case Enums.CellInMangerEdit.FinalDate.rawValue:
            _selectedTypeOfPicker = Enums.ManagerEditPagePickerStyle.FinalDate
			_selectedTypeOfDatePicker = .FinalDate
			doPicker(.Date)
		case Enums.CellInMangerEdit.RepairType.rawValue:
			performSegue(withIdentifier: "ToRepairTypeDetailViewController", sender: self)
		default:
			break
		}
	}
	
	//MARK: - Picker
	
	private func doPicker(_ type:Enums.PickerType){
		selectByDefault()
        switch type {
        case .Value:
			_pickerView.isHidden = false
			_pickerView.delegate = self
			_pickerView.dataSource = self
			
		case .Date:
			_datePicker.isHidden = false
		}
		self._toolBar.isHidden = false
	}
	
	public func SetRecordData(_ record:RecordData){
		_record = record
	}
    
    func selectByDefault(){
        _pickerView.selectRow(0, inComponent: 0, animated: false)
        _datePicker.setDate(Date(), animated: false)
    }
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		//TODO CHANGE TO SWITCH
		return 1
	}
	
	// data method to return the number of row shown in the picker.
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if _selectedTypeOfPicker != nil{
			switch _selectedTypeOfPicker! {
			case Enums.ManagerEditPagePickerStyle.Time:
				return _availibleIntervals.count
			case Enums.ManagerEditPagePickerStyle.State:
				return Constants.REPAIR_STATE.count
			case .Duration:
                return getAvailibleDurationsForStartTime().count
            case .Date:
                break
            case .FinalDate:
                break
            }
		}
		return 0
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		
		if _selectedTypeOfPicker != nil{
			switch _selectedTypeOfPicker! {
			case Enums.ManagerEditPagePickerStyle.Time:
				return (Constants.TIME_INTERVALS_DICTIONARY[_availibleIntervals[row]]!)[0...4]
			case Enums.ManagerEditPagePickerStyle.State:
				return Constants.REPAIR_STATE[row]
			case .Duration:
                return _availibleIntevalsTitles[row]
            case .Date:
                break
            case .FinalDate:
                break
            }
		}
		return nil
	}
	
	private func updateRecord(){
		let isUpdateSuccess = RequestManager.updateRecord(_record)
		let title = (isUpdateSuccess) ? "Успешно" : "Ошибка обновления"
		let message = (isUpdateSuccess) ? "Запись успешно обновлена" : "Проверьте данные и подключение к серверу"
		var alertActions:Dictionary<String,(UIAlertAction)->Void> = [:]
		if (isUpdateSuccess){
			alertActions["OK"] = {_ in self.navigationController?.popViewController(animated: true)}
		} else {
            alertActions["НАЗАД"] = {_ in }
            alertActions["ПОВТОРИТЬ"] = {_ in self.updateRecord()}
		}
		present(AlertManager.CreateDialog(inputTitle: title, inputMessage: message, actionsDict:alertActions),animated: true)
	}
	
	private func getStringLenghtFromIntervalString(_ string:String)->String{
		var result = ""
		if (string.count == 11){
			var hourPart =  Int(string[6...7])! - Int(string[0...1])!
			if (hourPart / 10 < 1){
				result.append("0")
			}
			var minutesPart =  Int(string[9...10])! - Int(string[3...4])!
			if (minutesPart / 10 < 0){
				hourPart -= 1
				minutesPart = abs(minutesPart)
			}
			result.append(String(hourPart) + "ч:" + String(minutesPart) + "мин")
			
		} else {
			result.append("00ч:00мин")
		}
		return result
	}
    
    private func getAvailibleDurationsForStartTime()->[String]{
        let emptyTimesForCreateRecord = RequestManager.getAvailibleIntervals(_record.date)
        var result:[String] = []
        var iter = 0
        
        if let currentIndex = Constants.TIME_INTERVALS_DURATION_BY_INDEX_DICTIONARY.first(where: { (key,value) -> Bool in
            value == _record.duration})?.key{
            for index in _record.timeIntervalIndex..<Constants.REVERT_TIME_INTERVALS_DICTIONARY.count {
                
                if let resValue = Constants.TIME_INTERVALS_DURATION_BY_INDEX_DICTIONARY[iter] , emptyTimesForCreateRecord.contains(index) {
                    result.append(resValue)
                }
                else{
                    if let resValue = Constants.TIME_INTERVALS_DURATION_BY_INDEX_DICTIONARY[iter] , iter <= currentIndex{
                        result.append(resValue)
                    }
                    else{
                        break
                    }
                }
                iter += 1
            }
        }
        _availibleIntevalsWithOutDescription = result
        return result
    }
    
    private func getAvailibleDurationsForStartTimeForTitle()->[String]{
        var result:[String] = []
        for value in getAvailibleDurationsForStartTime(){
            var temp = String()
            temp.append(contentsOf: value[0...1])
            temp.append(contentsOf: "ч")
            temp.append(contentsOf: value[3...4])
            temp.append(contentsOf: "мин")
            result.append(temp)
        }
        return result
    }
	
	//MARK: - Actions
	
	@IBAction func CallToClient(_ sender: Any) {
		if let userPhone = RequestManager.getUserData(userID: _record.userId)["Phone"] as? String{
			guard let number = URL(string: "tel://" + userPhone) else { return }
			UIApplication.shared.open(number)
		}
	}
	
	@IBAction func SendChangesForRecord(_ sender: Any) {
		updateRecord()
	}
	
	@objc func datePickerValueChanged(_ sender: UIDatePicker){
		let dateFormatter: DateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd/MM/yyyy"
		let selectedDate: String = dateFormatter.string(from: sender.date)
		switch(_selectedTypeOfDatePicker!){
		case Enums.ManagerEditPageDatePickerStyle.StartDate:
			_record.date = selectedDate
            if let firstDate = RequestManager.getAvailibleIntervals(selectedDate).first {
                _record.duration = Constants.TIME_INTERVALS_DURATION_BY_INDEX_DICTIONARY[0]!
                _record.timeIntervalIndex = firstDate
            }else{
                _record.duration = String()
                _record.timeIntervalIndex = -1
            }
		case Enums.ManagerEditPageDatePickerStyle.FinalDate:
			_record.repairDuration = selectedDate
		}
        
        if (RequestManager.getAvailibleIntervals(_record.date).count == 0){
            let alert = AlertManager.CreateDialog(inputTitle: "Внимание", inputMessage: "Свободные промежутки отсутсвуют", actionsDict: ["OK":{_ in}])
            present(alert, animated: true)
        }
        _areDatesAvailible = RequestManager.getAvailibleIntervals(_record.date).count != 0
        
		recordTableView.reloadData()
	}
	
	@objc func doneClick() {
        print(_pickerView.selectedRow(inComponent: 0))
        let row = _pickerView.selectedRow(inComponent: 0)
        if _selectedTypeOfPicker != nil{
            switch _selectedTypeOfPicker! {
            case Enums.ManagerEditPagePickerStyle.Time:
                _availibleIntevalsTitles = getAvailibleDurationsForStartTimeForTitle()
                    _record.timeIntervalIndex = (row < _availibleIntervals.count) ? _availibleIntervals[row] : -1
                
            case Enums.ManagerEditPagePickerStyle.State:
                _record.repairState = Constants.REPAIR_STATE[row]
            case .Duration:
                if let index = Constants.TIME_INTERVALS_DURATION_BY_INDEX_DICTIONARY.first(where: { (key,value) -> Bool in
                    if (row < _availibleIntevalsWithOutDescription.count){
                        let expected = _availibleIntevalsWithOutDescription[row]
                        return value == expected
                        
                    }
                    return false
                }
                    ){
                    if let value = Constants.TIME_INTERVALS_DURATION_BY_INDEX_DICTIONARY[index.key]{
                        _record.duration = value
                    }
                }
                break
            case .Date:
                datePickerValueChanged(_datePicker)
                break
            case .FinalDate:
                datePickerValueChanged(_datePicker)
                break
                
            }
            
        }
        
        recordTableView.reloadData()
		_pickerView.isHidden = true
		_datePicker.isHidden = true
		_toolBar.isHidden = true
		recordTableView.reloadData()
	}
	
	@objc func cancelClick() {
		_pickerView.isHidden = true
		_datePicker.isHidden = true
		_toolBar.isHidden = true
		recordTableView.reloadData()
	}
	
	//MARK: - Navigations
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? RepairTypeDetailViewController{
			destination.SetRecord(_record)
		}
	}
    
}

