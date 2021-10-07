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
        let userID = Auth.auth().currentUser?.uid
        
        self.ref.child("UserProfile").child(userID!).getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                let value = snapshot.value as? NSDictionary
                self.nameNewTF.text = value?["name"] as? String ?? ""
                self.apellidoNewTF.text = value?["lastName"] as? String ?? ""
                self.dateNewTF.text = value?["birthDate"] as? String ?? ""
            }
            else {
                print("No data available")
            }
        }
    }

    @IBAction func updateBtn(_ sender: Any) {
        
    }
    
    @IBAction func signoutBtn(_ sender: Any) {
        try! Auth.auth().signOut()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
