//
//  SignUp.swift
//  DonationsTracker
//
//  Created by user194269 on 9/1/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var nombreTF: UITextField!
    @IBOutlet weak var apellidoTF: UITextField!
    @IBOutlet weak var correoTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registerBtn(_ sender: AnyObject) {
        guard
            let email = correoTF.text,
            let password = passwordTF.text,
            !email.isEmpty,
            !password.isEmpty
        else{
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password){_, error in
            if error == nil{
                Auth.auth().signIn(withEmail: email, password: password)
            }
            else{
                print("Error in create User: \(error)")
            }
        }
    }
    
}
