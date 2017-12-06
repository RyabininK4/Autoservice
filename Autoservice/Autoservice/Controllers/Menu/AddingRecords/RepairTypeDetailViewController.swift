//
//  RepairTypeDetailViewController.swift
//  Autoservice
//
//  Created by артем on 01/12/2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import UIKit

class RepairTypeDetailViewController: BaseViewController,UITextViewDelegate {

    @IBOutlet weak var DescriptionTextEditOutlet: UITextView!
    
    private var _record:RecordData = RecordData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Initialise()
    }

    public func SetRecord(_ record :RecordData){
        _record = record
    }
    
    private func Initialise(){
        DescriptionTextEditOutlet.text = _record.RepairType
        DescriptionTextEditOutlet.delegate = self
        DescriptionTextEditOutlet.layer.cornerRadius = 5
        DescriptionTextEditOutlet.layer.borderColor = UIColor.black.cgColor
        DescriptionTextEditOutlet.layer.borderWidth = 0.5
        DescriptionTextEditOutlet.layer.masksToBounds = true
        addKeyboardHideHanlder()
    }
    
    //Delegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        SelectStartTextIfItExist()
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newString = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        _record.RepairType = newString
        return true
    }
    
    //Private
    private func SelectStartTextIfItExist(){
        if (DescriptionTextEditOutlet.text == Constants.RECORD_TYPE_DEFAULT_VALUE )
        {
            DispatchQueue.main.async {
                self.DescriptionTextEditOutlet.selectAll(nil)
            }
        }
    }

}
