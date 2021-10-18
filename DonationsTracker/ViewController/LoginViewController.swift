//
//  ViewController.swift
//  DonationsTracker
//
//  Copyright © 2021 Team5. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

// ViewController de la pantalla Login
class LoginViewController: UIViewController {

    // Referencias
    @IBOutlet weak var correoTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    let loginToList = "LoginToMain"
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    // Funcion cuando inicia la pantalla de Login
    override func viewDidLoad() {
        super.viewDidLoad()
        
        correoTF.delegate = self
        passwordTF.delegate = self
        
        // Para agregar contornos con color a dos TextField
        correoTF.layer.borderWidth = 2
        correoTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        correoTF.layer.cornerRadius = 8
        correoTF.layer.masksToBounds = true
        correoTF.text = ""
        
        passwordTF.layer.borderWidth = 2
        passwordTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordTF.layer.cornerRadius = 8
        passwordTF.layer.masksToBounds = true
        passwordTF.isSecureTextEntry = true
        passwordTF.text = ""
        
        // Para desactivar el teclado al presionar en cualquier parte de la pantalla
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.keyboardDismiss))
        view.addGestureRecognizer(tap)
    }
    
    // Para notificar que la vista está a punto de agregarse 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        handle = Auth.auth().addStateDidChangeListener{ _, user in
            if user != nil{
                self.performSegue(withIdentifier: self.loginToList, sender: nil)
                self.correoTF.text = nil
                self.passwordTF.text = nil
            }
            else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    // Para notificar que la vista fue agregada
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // Para notificar que la vista fue eliminada
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let handle = handle else{return }
        
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    // Funcion al presionar el boton de Login
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
                    title: "Error de Autenticación",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // Funcion para esconder teclado
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
