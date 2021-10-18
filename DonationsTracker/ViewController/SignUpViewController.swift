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

// ViewController para pantalla de SignUp
class SignUpViewController: UIViewController {
    
    let ref = Database.database().reference()  //Global Variable

    // Texfields
    @IBOutlet weak var nombreTF: UITextField!
    @IBOutlet weak var apellidoTF: UITextField!
    @IBOutlet weak var correoTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    
    // Tipo de usuario por default
    let userType = "General"
    
    // URL del Aviso de Privacidad 
    let avisoPage = "https://bdalimentos.org/aviso/"
    
    // Funcion al cargar la vista
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Para agregar contorno y color a TextField
        
        nombreTF.layer.borderWidth = 1
        nombreTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        nombreTF.layer.cornerRadius = 8
        nombreTF.layer.masksToBounds = true
        nombreTF.text = ""
        
        apellidoTF.layer.borderWidth = 1
        apellidoTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        apellidoTF.layer.cornerRadius = 8
        apellidoTF.layer.masksToBounds = true
        apellidoTF.text = ""
        
        correoTF.layer.borderWidth = 1
        correoTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        correoTF.layer.cornerRadius = 8
        correoTF.layer.masksToBounds = true
        correoTF.text = ""
        
        passwordTF.layer.borderWidth = 1
        passwordTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordTF.layer.cornerRadius = 8
        passwordTF.layer.masksToBounds = true
        passwordTF.isSecureTextEntry = true
        passwordTF.text = ""

        navigationController?.navigationBar.isHidden = false

        // Para esconder teclado al presionar pantalla
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.keyboardDismiss))
        view.addGestureRecognizer(tap)
        
    }
    
    // Funcion al presionar el aviso privacidad
    @IBAction func OpenAviso(_ sender: Any) {
        if let url = URL(string: avisoPage) {
            UIApplication.shared.open(url)
        }
    }
    
    // Funcion al presionar boton de registrar
    @IBAction func registerBtn(_ sender: AnyObject) {
        guard
            let email = correoTF.text,
            let password = passwordTF.text,
            !email.isEmpty,
            !password.isEmpty
        else{
            return
        }
        
        // Crear usuario
        Auth.auth().createUser(withEmail: email, password: password){authResult, error in
            if error == nil{
            
                let ref = Database.database().reference()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/YY"
                ref.child("UserProfile").child(authResult!.user.uid).setValue([
                    "name" : self.nombreTF.text!,
                    "lastName" : self.apellidoTF.text!,
                    "birthDate" : dateFormatter.string(from: self.birthDatePicker.date),
                    "userType" : self.userType,
                    "donations": 0,
                    "families": 0,
                    "level": "Plátano",
                    "logros": [
                        "Logro1": false,
                        "Logro2": false,
                        "Logro3": false
                                ]
                            ])
                
                self.correoTF.text = ""
                self.passwordTF.text = ""
                self.nombreTF.text = ""
                self.apellidoTF.text = ""
                
                // Mostrar alerta cuando se guardaron los datos con exito
                let alert = UIAlertController(
                    title: "Creado",
                    message: "Se creo usuario exitosamente",
                    preferredStyle: .alert
                )
                
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                print("Error in create User: \(error?.localizedDescription ?? "Undefined")")
            }
        }
    }
    
    // Funcion para esconder teclado
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
    
}
