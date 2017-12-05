//
//  AddingRepairRecordTableViewController.swift
//  Autoservice
//
//  Created by артем on 01/12/2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import UIKit

class AddingRepairRecordTableViewController: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet var RecordTableView: UITableView!
    @IBOutlet var DatePicker: UIDatePicker!
    @IBOutlet var PickerView: UIPickerView!
    
    private let dateFormatter = DateFormatter()
    private let locale = NSLocale.current
    private let toolBar = UIToolbar()
    private var intervalPicker:UIPickerView = UIPickerView()
    private let record:RecordData = RecordData()
    
    private let marks:[String] = ["Audi","Ford","Nissan"]
    private let models:[String] = ["0","1","2"]
    
    private let NAV_BAR_ITEM_HEIGHT:CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitIntervalPicker()
    }

    private func InitializeDatePicker(){
        self.DatePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
        self.DatePicker?.backgroundColor = UIColor.white
        self.DatePicker?.datePickerMode = UIDatePickerMode.dateAndTime
        DatePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        DatePicker.center = CGPoint(x:view.center.x,y: view.frame.height - DatePicker.frame.height/2 - NAV_BAR_ITEM_HEIGHT )
    }
    
    private func InitializeValuePicker(){
        self.PickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
        self.PickerView?.backgroundColor = UIColor.white
        self.PickerView.delegate = self
        self.PickerView.dataSource = self
        PickerView.center = CGPoint(x:view.center.x,y: view.frame.height - DatePicker.frame.height/2 - NAV_BAR_ITEM_HEIGHT )
    }
    
    private func InitializeToolBar(){
        
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddingRepairRecordTableViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AddingRepairRecordTableViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x:0,y:view.frame.height - 200 - toolBar.frame.height - NAV_BAR_ITEM_HEIGHT,
                               width:view.frame.width,height:toolBar.frame.height)
    }
    
    private func InitIntervalPicker(){
        intervalPicker.delegate = self
        intervalPicker.dataSource = self
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let selectedDate: String = dateFormatter.string(from: sender.date)
        record.Date = selectedDate
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
            detailCellInfo = record.Date
        case Enums.CellInAddingRecord.Time.rawValue:
            cellIdentifier = "RecordTime"
            detailCellInfo = String(record.TimeIntervalIndex)
        case Enums.CellInAddingRecord.Mark.rawValue:
            cellIdentifier = "CarMarkCell"
            detailCellInfo = record.Mark
        case Enums.CellInAddingRecord.Model.rawValue:
            cellIdentifier = "ModelCell"
            detailCellInfo = record.Model
        case Enums.CellInAddingRecord.RepairType.rawValue:
            cellIdentifier = "RepairType"
        default:
            break
        }
        if indexPath.row == Enums.CellInAddingRecord.RepairType.rawValue {
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath) as? RepairTypeCell{
                cell.SetData(remontDescription: record.RepairType)
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
        case Enums.CellInAddingRecord.Time.rawValue,
             Enums.CellInAddingRecord.Mark.rawValue,
             Enums.CellInAddingRecord.Model.rawValue:
            doDatePicker(.Value)
         case Enums.CellInAddingRecord.RepairType.rawValue:
            performSegue(withIdentifier: "RepairTypeDetailIdentifier", sender: self)
        default:
            break
        }
    }
    
    private func CreatePicker()->UIPickerView{
        let picker:UIPickerView = UIPickerView()
        picker.frame = CGRect(x:0, y: view.frame.height - 200, width: view.frame.width, height: 200)
        return picker
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // data method to return the number of row shown in the picker.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case Enums.CellInAddingRecord.Time.rawValue:
            return Constants.TIME_INTERVALS_DICTIONARY.count
        case Enums.CellInAddingRecord.Mark.rawValue:
            return marks.count
        case Enums.CellInAddingRecord.Model.rawValue:
            return models.count
        default:
            return 0
        }
    }
    
    private func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case Enums.CellInAddingRecord.Time.rawValue:
            return Constants.TIME_INTERVALS_DICTIONARY[row]
        case Enums.CellInAddingRecord.Mark.rawValue:
            return marks[row]
        case Enums.CellInAddingRecord.Model.rawValue:
            return models[row]
        default:
            return "Something goes wrong"
        }
    }
    
    // delegate method called when the row was selected.
    private func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        record.TimeIntervalIndex = row
        RecordTableView.reloadData()
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    

    func doDatePicker(_ type:Enums.PickerType){
        InitializeToolBar()
        switch type {
        case .Value:
            InitializeValuePicker()
            if(!DatePicker.isHidden) {DatePicker.isHidden = true}
            view.addSubview(self.PickerView)
        case .Date:
            InitializeDatePicker()
            if(!PickerView.isHidden) {PickerView.isHidden = true}
            view.addSubview(self.DatePicker)
        }
        self.view.addSubview(toolBar)
        self.toolBar.isHidden = false
    }
    
    @objc func doneClick() {
        RecordTableView.reloadData()
        if(!self.DatePicker.isHidden) {self.DatePicker.isHidden = true}
        if(!self.PickerView.isHidden) {self.PickerView.isHidden = true}
        self.toolBar.isHidden = true
    }
    
    @objc func cancelClick() {
        if(!self.DatePicker.isHidden) {self.DatePicker.isHidden = true}
        if(!self.PickerView.isHidden) {self.PickerView.isHidden = true}
        self.toolBar.isHidden = true
        RecordTableView.reloadData()
    }

}
