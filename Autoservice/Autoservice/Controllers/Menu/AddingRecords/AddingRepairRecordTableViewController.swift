//
//  AddingRepairRecordTableViewController.swift
//  Autoservice
//
//  Created by артем on 01/12/2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import UIKit

class AddingRepairRecordTableViewController: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource {
	
    @IBAction func SendBarButton(_ sender: Any) {
        var title:String = String()
        var message:String = String()
        
        if (!RequestManager.createRecordOnServ(_record)){
            title = "Ошибка"
            message = "Неверные данные"
        }
        else{
            title = "Успешно"
            message = "Запрос успешно отправлен"
        }
        let alert = AlertManager.CreateDialog(inputTitle: title, inputMessage: message, actionsDict: ["OK":{_ in}])
        present(alert, animated: true)
    }
    
    @IBOutlet var RecordTableView: UITableView!
	
	private let _dateFormatter = DateFormatter()
	private let _locale = NSLocale.current
    private var _toolBar = UIToolbar()
    private var _pickerView = UIPickerView()
    private var _datePicker = UIDatePicker()
    private var _availibleIntervals:[Int] = []
    private let _record:RecordData = RecordData(TimeIntervalIndex:0,RepairType:Constants.RECORD_TYPE_DEFAULT_VALUE)
	//TODO Check connection
	private let _marks:[String] = RequestManager.getAutoBrands()
	private var _models:[String] = []
	
	private let NAV_BAR_ITEM_HEIGHT:CGFloat = 44
    
    
    private var _selectedTypeOfPicker:Enums.AddingRecordPagePickerStyle?
	
	override func viewDidLoad() {
		super.viewDidLoad()
        InitializeToolBar()
        InitializeDatePicker()
        InitializeValuePicker()
	}
    
    override func viewWillAppear(_ animated: Bool) {
        RecordTableView.reloadData()
    }
	
	private func InitializeDatePicker(){
        _datePicker = InputViewManager.InitializeDatePicker(view: self.view)
		_datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
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
	
	
	@objc func datePickerValueChanged(_ sender: UIDatePicker){
		let dateFormatter: DateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd/MM/yyyy"
		let selectedDate: String = dateFormatter.string(from: sender.date)
		_record.Date = selectedDate
		RecordTableView.reloadData()
	}
	
	//TableView
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cellIdentifier:String = String()
		var detailCellInfo:String = String()
		switch indexPath.row {
		case Enums.CellInAddingRecord.Date.rawValue:
			cellIdentifier = "RecordDate"
			detailCellInfo = _record.Date
		case Enums.CellInAddingRecord.Time.rawValue:
			cellIdentifier = "RecordTime"
            detailCellInfo = Constants.TIME_INTERVALS_DICTIONARY[_record.TimeIntervalIndex]!
		case Enums.CellInAddingRecord.Mark.rawValue:
			cellIdentifier = "CarMarkCell"
			detailCellInfo = _record.Mark
		case Enums.CellInAddingRecord.Model.rawValue:
			cellIdentifier = "ModelCell"
			detailCellInfo = _record.Model
		case Enums.CellInAddingRecord.RepairType.rawValue:
			cellIdentifier = "RepairType"
		default:
			break
		}
		if indexPath.row == Enums.CellInAddingRecord.RepairType.rawValue {
			if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath) as? RepairTypeCell{
				cell.SetData(remontDescription: _record.RepairType)
				return cell
			}
		}
		else {
			let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath)
			cell.detailTextLabel?.text = detailCellInfo
			return cell
			
		}
		return UITableViewCell()
		
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.row {
		case Enums.CellInAddingRecord.Date.rawValue:
			doDatePicker(.Date)
        case Enums.CellInAddingRecord.Time.rawValue:
            _selectedTypeOfPicker = Enums.AddingRecordPagePickerStyle.Time
            _availibleIntervals = RequestManager.getAvailibleIntervals(_record.Date)
            doDatePicker(.Value)
        case Enums.CellInAddingRecord.Mark.rawValue:
            _selectedTypeOfPicker = Enums.AddingRecordPagePickerStyle.Mark
            doDatePicker(.Value)
        case Enums.CellInAddingRecord.Model.rawValue:
            _selectedTypeOfPicker = Enums.AddingRecordPagePickerStyle.Model
            doDatePicker(.Value)
		case Enums.CellInAddingRecord.RepairType.rawValue:
			performSegue(withIdentifier: "RepairTypeDetailIdentifier", sender: self)
		default:
			break
		}
	}
	
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	// data method to return the number of row shown in the picker.
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if _selectedTypeOfPicker != nil{
            switch _selectedTypeOfPicker! {
            case Enums.AddingRecordPagePickerStyle.Time:
                
                return _availibleIntervals.count
            case Enums.AddingRecordPagePickerStyle.Mark:
                return _marks.count
            case Enums.AddingRecordPagePickerStyle.Model:
                return _models.count
            }
        }
		return 0
	}
	
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		
        if _selectedTypeOfPicker != nil{
            switch _selectedTypeOfPicker! {
            case Enums.AddingRecordPagePickerStyle.Time:
                return Constants.TIME_INTERVALS_DICTIONARY[_availibleIntervals[row]]
            case Enums.AddingRecordPagePickerStyle.Mark:
                return _marks[row]
            case Enums.AddingRecordPagePickerStyle.Model:
                return _models[row]
        }
        }
        return nil
	}
	
	// delegate method called when the row was selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		
        if _selectedTypeOfPicker != nil{
            switch _selectedTypeOfPicker! {
            case Enums.AddingRecordPagePickerStyle.Time:
                _record.TimeIntervalIndex = _availibleIntervals[row]
            case Enums.AddingRecordPagePickerStyle.Mark:
                _record.Mark = _marks[row]
                _models = RequestManager.getAutoModels(brand:_record.Mark)
            case Enums.AddingRecordPagePickerStyle.Model:
                _record.Model = _models[row]
                
            }
        }
		RecordTableView.reloadData()
	}
	
    /*TODO
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
     // MARK: - Navigation
     
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RepairTypeDetailViewController{
            destination.SetRecord(_record)
        }
     }
	
	private func doDatePicker(_ type:Enums.PickerType){
		doneClick()
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
	
	@objc func doneClick() {
        _pickerView.isHidden = true
        _datePicker.isHidden = true
		_toolBar.isHidden = true
        RecordTableView.reloadData()
	}
	
	@objc func cancelClick() {
        _pickerView.isHidden = true
        _datePicker.isHidden = true
		_toolBar.isHidden = true
		RecordTableView.reloadData()
	}
	
}
