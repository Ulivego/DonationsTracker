//
//  CreateEventViewController.swift
//  DonationsTracker
//
//  Created by user193315 on 9/7/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    @IBOutlet weak var tituloEventoTF: UITextField!
    
    @IBOutlet weak var descriptionTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tituloEventoTF.layer.borderWidth = 2
        tituloEventoTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tituloEventoTF.layer.cornerRadius = 8
        tituloEventoTF.layer.masksToBounds = true
        
        descriptionTF.layer.borderWidth = 2
        descriptionTF.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        descriptionTF.layer.cornerRadius = 8
        descriptionTF.layer.masksToBounds = true
       
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.keyboardDismiss))
        
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func datePicker(_ sender: Any) {
    }
    
    @IBAction func listoBtn(_ sender: Any) {
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
}

