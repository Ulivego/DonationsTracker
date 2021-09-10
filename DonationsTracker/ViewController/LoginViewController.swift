//
//  ViewController.swift
//  DonationsTracker
//
//  Created by Ana on 8/30/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

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
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.keyboardDismiss))
        
        view.addGestureRecognizer(tap)
    }

    @IBAction func loginBtn(_ sender: Any) {
        
        if  let email = correoTF.text,
            let password = passwordTF.text {
            Auth.auth().createUser(withEmail: email, password: password) {
                (result, error) in
                
                if let result = result, error == nil {
                    
                    
                    
                } else {
                    let alertController = UIAlertController(title: "Error",
                        message:
                                "Se ha producido un error al registrar el usuario",
                        preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "Aceptar",
                        style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    @IBAction func registerBtn(_ sender: Any) {
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
}

