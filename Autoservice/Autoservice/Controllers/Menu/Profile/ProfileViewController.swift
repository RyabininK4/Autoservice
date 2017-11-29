//
//  ProfileViewController.swift
//  Autoservice
//
//  Created by артем on 29/11/2017.
//  Copyright © 2017 Kirill Ryabinin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBAction func ExitButton(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: Constants.USER_ID_USER_DEFAULTS_KEY)
        if let loginVC = storyboard?.instantiateInitialViewController(){
            present(loginVC, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
