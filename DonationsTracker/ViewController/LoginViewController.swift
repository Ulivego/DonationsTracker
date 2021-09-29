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
    
    let loginToList = "LoginToMain"
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        correoTF.delegate = self
        passwordTF.delegate = self
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        handle = Auth.auth().addStateDidChangeListener{ _, user in
            if user == nil{
                self.navigationController?.popToRootViewController(animated: true)
            }
            else {
                self.performSegue(withIdentifier: self.loginToList, sender: nil)
                self.correoTF.text = nil
                self.passwordTF.text = nil
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let handle = handle else{return }
        
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    @IBAction func loginDidTouch(_ sender: AnyObject){
        guard
            let email = correoTF.text,
            let password = passwordTF.text,
            !email.isEmpty,
            !password.isEmpty
        else{
            return
        }
        
        // Start login
        Auth.auth().signIn(withEmail: email, password: password){
            user, error in
            if let error = error, user == nil{
                let alert = UIAlertController(
                    title: "Sign in failed",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    /*@IBAction func loginBtn(_ sender: Any) {
        
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
    }*/
    
    @IBAction func registerBtn(_ sender: Any) {
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == correoTF {
            passwordTF.becomeFirstResponder()
        }
        if textField == passwordTF{
            textField.resignFirstResponder()
        }
        return true
    }
}
