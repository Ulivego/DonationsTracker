//
//  PreferencesViewController.swift
//  DonationsTracker
//
//  Created by user194269 on 9/1/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import UIKit
import Firebase

class EconomicDonationsViewController: UIViewController {

    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var ownerName: UITextField!
    @IBOutlet weak var monthCard: UITextField!
    @IBOutlet weak var yearCard: UITextField!
    @IBOutlet weak var cvNumber: UITextField!
    @IBOutlet weak var donationAmount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EconomicDonationsViewController.keyboardDismiss))
        
        view.addGestureRecognizer(tap)
        
        cardNumber.tag = 1
        ownerName.tag = 2
        monthCard.tag = 3
        yearCard.tag = 4
        cvNumber.tag = 5
        donationAmount.tag = 6
        
        cardNumber.delegate = self
        ownerName.delegate = self
        monthCard.delegate = self
        yearCard.delegate = self
        cvNumber.delegate = self
        donationAmount.delegate = self
    }
    
    

    @IBAction func makePayment(_ sender: Any) {
        guard
            let cardNumberText = cardNumber.text,
            let ownerNameText = ownerName.text,
            let expireMonthText = monthCard.text,
            let expireYearText = yearCard.text,
            let cvNumberText = cvNumber.text,
            let donationAmountText = donationAmount.text
        else {
            let alert = UIAlertController(title: "Información Incompleta", message: "Por favor llene correctamente la información", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Cerrar", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let database = Database.database().reference()
        
        let payment: [String: Any] = [
            "cardNumber": cardNumberText,
            "ownerName": ownerNameText,
            "expireDate": expireMonthText + "/" + expireYearText,
            "donationAmount": donationAmountText
        ]
        
        database.child("Payments").childByAutoId().setValue(payment)
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }

}

extension EconomicDonationsViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Check if there is any other text-field in the view whose tag is +1 greater than the current text-field on which the return key was pressed. If yes → then move the cursor to that next text-field. If No → Dismiss the keyboard
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
