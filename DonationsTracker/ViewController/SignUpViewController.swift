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
    
    let ref = Database.database().reference()  //Global Variable

    @IBOutlet weak var nombreTF: UITextField!
    @IBOutlet weak var apellidoTF: UITextField!
    @IBOutlet weak var correoTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    let userType = "General"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.keyboardDismiss))
        
        view.addGestureRecognizer(tap)
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
        
        Auth.auth().createUser(withEmail: email, password: password){authResult, error in
            if error == nil{
            
                let ref = Database.database().reference()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YY/MM/dd"
                ref.child("UserProfile").child(authResult!.user.uid).setValue([
                    "name" : self.nombreTF.text!,
                    "lastName" : self.apellidoTF.text!,
                    "birthDate" : dateFormatter.string(from: self.birthDatePicker.date),
                    "userType" : self.userType,
                    "dononations": 0,
                    "families": 0,
                    "level": "Plátano",
                    "logros": [
                        "Logro1": false,
                        "Logro2": false,
                        "Logro3": false
                                ]
                            ])
                print("Registrado")
                self.correoTF.text = ""
                self.passwordTF.text = ""
                self.nombreTF.text = ""
                self.apellidoTF.text = ""
            }
            else{
                print("Error in create User: \(error?.localizedDescription ?? "Undefined")")
            }
        }
    }
    
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
    
}
