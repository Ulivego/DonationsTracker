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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        /*Auth.auth().createUser(withEmail: email, password: password){_, error in
            if error == nil{
                Auth.auth().signIn(withEmail: email, password: password)
            }
            else{
                print("Error in create User: \(error?.localizedDescription ?? "Undefined")")
            }
        }*/
        
        /*Auth.auth().createUser(withEmail: correoTF.text!, password: passwordTF.text!, completion: { user, error in
            if let error = error {
                print("Error in create User")
            } else {
                ref.child("UserProfile").child(user?.user.email).setValue([
                            "name" : nombreTF.text!,
                            "lastName" : apellidoTF.text!,
                            "birthDate" : birthDatePicker.date
                            ])
             }
          })
        }*/
    }
    
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
    
}
