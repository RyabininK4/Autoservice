//
//  ManagerDetailRecordTableViewController.swift
//  Autoservice
//
//  Created by артем on 13/12/2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import UIKit

class ManagerDetailRecordTableViewController: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet var recordTableView: UITableView!
    @IBOutlet weak var PhoneBarButtonItem: UIBarButtonItem!
    
    @IBAction func CallToClient(_ sender: Any) {
        if let userPhone = RequestManager.getUserData(userID: _record.UserId)["Phone"] as? String{
            guard let number = URL(string: "tel://" + userPhone) else { return }
            UIApplication.shared.open(number)
        }
    }
    
    @IBAction func SendChangesForRecord(_ sender: Any) {
        updateRecord()
    }
    
    private var _record:RecordData = RecordData()
    private var _selectedTypeOfPicker:Enums.ManagerEditPagePickerStyle?
    private var _selectedTypeOfDatePicker:Enums.ManagerEditPageDatePickerStyle?
    private var _toolBar = UIToolbar()
    private var _pickerView = UIPickerView()
    private var _datePicker = UIDatePicker()
    private var _availibleIntervals:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitializeToolBar()
        InitializeDatePicker()
        InitializeValuePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recordTableView.reloadData()
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
        switch(_selectedTypeOfDatePicker!){
        case Enums.ManagerEditPageDatePickerStyle.StartDate:
            _record.Date = selectedDate
        
        case Enums.ManagerEditPageDatePickerStyle.FinalDate:
            _record.RepairDuration = selectedDate
        }
        recordTableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellIdentifier:String = String()
        var detailCellInfo:String = String()
        var isCellAvailible = true
        let areStartDateAndDurationAvailible:Bool = (_record.RepairState == Constants.REPAIR_STATE.first)
        switch indexPath.row {
        case Enums.CellInMangerEdit.Date.rawValue:
            isCellAvailible = areStartDateAndDurationAvailible
            cellIdentifier = "RecordDate"
            detailCellInfo = _record.Date
        case Enums.CellInMangerEdit.Time.rawValue:
            isCellAvailible = areStartDateAndDurationAvailible
            cellIdentifier = "RecordTime"
            detailCellInfo = Constants.TIME_INTERVALS_DICTIONARY[_record.TimeIntervalIndex]![0...4]
        case Enums.CellInMangerEdit.RepairStatus.rawValue:
            cellIdentifier = "RepairStatusCell"
            detailCellInfo = _record.RepairState
        case Enums.CellInMangerEdit.FinalDate.rawValue:
            cellIdentifier = "FinalDate"
            detailCellInfo = _record.RepairDuration
        case Enums.CellInMangerEdit.RepairType.rawValue:
            cellIdentifier = "RepairType"
        case Enums.CellInMangerEdit.Duration.rawValue:
            let interval = Constants.TIME_INTERVALS_DICTIONARY[_record.TimeIntervalIndex]!
            cellIdentifier = "DurationTime"
            detailCellInfo = getStringLenghtFromIntervalString(interval)
        default:
            break
        }
        if indexPath.row == Enums.CellInMangerEdit.RepairType.rawValue {
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath) as? RepairTypeCell{
                cell.SetData(remontDescription: _record.RepairType)
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
        let alertMessage = "Для статуса '" + _record.RepairState + "' данное поле неизменяемо"
        let alert = AlertManager.CreateDialog(inputTitle: alertTitle, inputMessage: alertMessage, actionsDict: ["ОК":{_ in }])
        let areStartDateAndDurationAvailible:Bool = (_record.RepairState == Constants.REPAIR_STATE.first)
        switch indexPath.row {
        case Enums.CellInMangerEdit.Date.rawValue:
            _selectedTypeOfDatePicker = .StartDate
            (areStartDateAndDurationAvailible) ? doPicker(.Date) : present(alert,animated: true)
        case Enums.CellInMangerEdit.Time.rawValue:
            _selectedTypeOfPicker = Enums.ManagerEditPagePickerStyle.Time
            _availibleIntervals = RequestManager.getAvailibleIntervals(_record.Date)
            (areStartDateAndDurationAvailible) ? doPicker(.Value) : present(alert,animated: true)
        case Enums.CellInMangerEdit.RepairStatus.rawValue:
            _selectedTypeOfPicker = Enums.ManagerEditPagePickerStyle.State
            doPicker(.Value)
        case Enums.CellInMangerEdit.FinalDate.rawValue:
            _selectedTypeOfDatePicker = .FinalDate
            doPicker(.Date)
        case Enums.CellInMangerEdit.RepairType.rawValue:
            performSegue(withIdentifier: "ToRepairTypeDetailViewController", sender: self)
        default:
            break
        }
    }
    
    private func doPicker(_ type:Enums.PickerType){
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
        recordTableView.reloadData()
    }
    
    @objc func cancelClick() {
        _pickerView.isHidden = true
        _datePicker.isHidden = true
        _toolBar.isHidden = true
        recordTableView.reloadData()
    }
    
    public func SetRecordData(_ record:RecordData){
        _record = record
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
                break
            }
        }
        return nil
    }
    
    // delegate method called when the row was selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if _selectedTypeOfPicker != nil{
            switch _selectedTypeOfPicker! {
            case Enums.ManagerEditPagePickerStyle.Time:
                _record.TimeIntervalIndex = _availibleIntervals[row]
            case Enums.ManagerEditPagePickerStyle.State:
                _record.RepairState = Constants.REPAIR_STATE[row]
            case .Duration:
                break
            }
        }
        recordTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RepairTypeDetailViewController{
            destination.SetRecord(_record)
        }
    }
    
    private func updateRecord(){
        let isUpdateSuccess = RequestManager.updateRecord(_record)
        let title = (isUpdateSuccess) ? "Успешно" : "Ошибка обновления"
        let message = (isUpdateSuccess) ? "Запись успешно обновлена" : "Проверьте данные и подключение к серверу"
        var alertActions:Dictionary<String,(UIAlertAction)->Void> = [:]
        if (isUpdateSuccess){
            alertActions["OK"] = {_ in self.navigationController?.popViewController(animated: true)}
        } else {
            alertActions["ПОВТОРИТЬ"] = {_ in self.updateRecord()}
            alertActions["К СПИСКУ"] = {_ in self.navigationController?.popViewController(animated: true)}
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
    
}

