//
//  UserRecordsViewController.swift
//  Autoservice
//
//  Created by Kirill Ryabinin on 06.12.2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import UIKit

class UserRecordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableView : UITableView!

    private var _userId:Int = Constants.INVALIDE_INT_VALUE
    private var _isUserManager:Bool = false
    private var _selectedRecord:RecordData = RecordData()
    private var _records:[RecordData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _userId = UserDefaults.standard.integer(forKey: Constants.USER_ID_USER_DEFAULTS_KEY)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _records = RequestManager.getRecordsFromServer(userId: ((!_isUserManager) ? _userId : Constants.INVALIDE_INT_VALUE))
        if let isUserAdmin = (RequestManager.getUserData(userID: _userId)["IsManager"]) as? String{
            _isUserManager = (isUserAdmin == "FALSE") ? false : true
        }
        tableView.reloadData()
    }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return _records.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "infoRecord") as! UserRecordsTableViewCell
        cell.SetData(recordData: _records[indexPath.row])
		return cell
	}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _selectedRecord = _records[indexPath.row]
        performSegue(withIdentifier: "ToEditByManagerViewControllerSegueIdentifier", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return _isUserManager
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let title = "Внимание"
            let message = "Вы уверены что хотите удалить запись на " + _records[indexPath.row].Date + " число ?"
            var alertActions:Dictionary<String,(UIAlertAction)->Void> = [:]
            alertActions["НЕТ"] = {_ in }
            alertActions["ДА"] = {_ in self.showDeleteResult(self._records[indexPath.row].Id)}
            present(AlertManager.CreateDialog(inputTitle: title, inputMessage: message, actionsDict: alertActions), animated: true )
            
        }
    }
    private func showDeleteResult(_ recordId:Int){
        let deleteResult = RequestManager.delRecord(recordId)
        let title = (deleteResult) ? "Успешно" : "Ошибка"
        let message = (deleteResult) ? "Запись удалена" : "Проверьте соединение с сервером"
        var alertActions:Dictionary<String,(UIAlertAction)->Void> = [:]
        if (deleteResult){
            alertActions["OK"] = {_ in
                self._records = RequestManager.getRecordsFromServer(userId: ((!self._isUserManager)
                    ? self._userId
                    : Constants.INVALIDE_INT_VALUE))
                self.tableView.reloadData()

            }
        } else {
            alertActions["ПОВТОРИТЬ"] = {_ in self.showDeleteResult(recordId)}
            alertActions["К СПИСКУ"] = {_ in }
        }
        present(AlertManager.CreateDialog(inputTitle: title, inputMessage: message, actionsDict: alertActions), animated: true )
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToEditByManagerViewControllerSegueIdentifier"{
            if let destination = segue.destination as? ManagerDetailRecordTableViewController{
                destination.SetRecordData(_selectedRecord)
            }
        }
    }
}
