//
//  ViewController.swift
//  DonationsTracker
//
//  Created by Ana on 8/30/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var correoTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        correoTF.layer.borderWidth = 2
        correoTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        correoTF.layer.cornerRadius = 8
        correoTF.layer.masksToBounds = true
        
        passwordTF.layer.borderWidth = 2
        passwordTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordTF.layer.cornerRadius = 8
        passwordTF.layer.masksToBounds = true
    }

    @IBAction func loginBtn(_ sender: Any) {
    }
    
    
    @IBAction func registerBtn(_ sender: Any) {
    }
    
}

