		//
//  PreferenceViewController.swift
//  DonationsTracker
//
//  Created by user198130 on 9/10/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class PreferenceViewController: UIViewController {
    
    let ref = Database.database().reference()  //Global Variable

    @IBOutlet weak var nameNewTF: UITextField!
    @IBOutlet weak var apellidoNewTF: UITextField!
    @IBOutlet weak var mailNewTF: UITextField!
    @IBOutlet weak var passwordNewTF: UITextField!
    @IBOutlet weak var dateNewTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tabBarController?.hidesBottomBarWhenPushed = true
        
        let user = Auth.auth().currentUser
        let userID = user?.uid
        
        nameNewTF.layer.borderWidth = 1
        nameNewTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        nameNewTF.layer.cornerRadius = 8
        nameNewTF.layer.masksToBounds = true
        
        apellidoNewTF.layer.borderWidth = 1
        apellidoNewTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        apellidoNewTF.layer.cornerRadius = 8
        apellidoNewTF.layer.masksToBounds = true
        
        mailNewTF.layer.borderWidth = 1
        mailNewTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        mailNewTF.layer.cornerRadius = 8
        mailNewTF.layer.masksToBounds = true
        
        passwordNewTF.layer.borderWidth = 1
        passwordNewTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordNewTF.layer.cornerRadius = 8
        passwordNewTF.layer.masksToBounds = true
        passwordNewTF.isSecureTextEntry = true
        
        dateNewTF.layer.borderWidth = 1
        dateNewTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        dateNewTF.layer.cornerRadius = 8
        dateNewTF.layer.masksToBounds = true
        
        nameNewTF.layer.borderWidth = 1
        nameNewTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        nameNewTF.layer.cornerRadius = 8
        nameNewTF.layer.masksToBounds = true
        
        self.ref.child("UserProfile").child(userID!).getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                let value = snapshot.value as? NSDictionary
                self.nameNewTF.text = value?["name"] as? String ?? ""
                self.apellidoNewTF.text = value?["lastName"] as? String ?? ""
                self.dateNewTF.text = value?["birthDate"] as? String ?? ""
                self.mailNewTF.text = user?.email
            }
            else {
                print("No data available")
            }
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.keyboardDismiss))
        
        view.addGestureRecognizer(tap)
    }

    @IBAction func updateBtn(_ sender: Any) {
        let userID = Auth.auth().currentUser?.uid

        var userInfo: User?
        
        let key = ref.child("UserProfile").child(userID!).key
        ref.child("UserProfile").child(userID!).observe(.value){ snapshot in
            
            userInfo = User(snapshot: snapshot)
            var numLogro = 0
            let logros = userInfo?.logros?.reduce([String: Bool]()) { (dict, value) -> [String: Bool] in
                numLogro += 1
                var dict = dict
                dict["Logro\(numLogro)"] = value
                return dict
            }
            
            let data = ["birthDate": self.dateNewTF.text,
                        "lastName": self.apellidoNewTF.text,
                        "name": self.nameNewTF.text,
                        "donations": userInfo?.total,
                        "families": userInfo?.families,
                        "userType" : userInfo?.userType,
                        "level": userInfo?.level,
                        "logros": logros] as [String : Any]
            
            let childUpdates = ["/UserProfile/\(key!)": data]
            self.ref.updateChildValues(childUpdates)
            
        }
        
        var flag = true
        Auth.auth().currentUser?.updateEmail(to: mailNewTF.text!) { error in
            if error != nil {
                let alert = UIAlertController(
                    title: "Error en correo y contraseña",
                    message: "Cierre sesion e inicie una nueva sesion",
                    preferredStyle: .alert
                )
                
                alert.addAction(UIAlertAction(title: "Cerrar", style: .default))
                self.present(alert, animated: true, completion: nil)
                flag = false
            }
        }
        
        if flag == false {
            return
        }
        
        if (Int(passwordNewTF.text!.count) > 0){
            Auth.auth().currentUser?.updatePassword(to: passwordNewTF.text!) { error in
                if error != nil {
                    let alert = UIAlertController(
                        title: "Error en contraseña",
                        message: "Requiere minimo 6 caracteres",
                        preferredStyle: .alert
                    )
                    
                    alert.addAction(UIAlertAction(title: "Cerrar", style: .default))
                    self.present(alert, animated: true, completion: nil)
                    flag = false
                }
            }
        } 
        
        if flag == false {
            return
        }
        
        let alert = UIAlertController(
            title: "Actualizado",
            message: "Se guardo exitosamente",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cerrar", style: .default))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func signoutBtn(_ sender: Any) {
        try! Auth.auth().signOut()
        self.navigationController?.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
    
}
