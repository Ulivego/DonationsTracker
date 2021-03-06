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

    // Textfields para el pago
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var ownerName: UITextField!
    @IBOutlet weak var monthCard: UITextField!
    @IBOutlet weak var yearCard: UITextField!
    @IBOutlet weak var cvNumber: UITextField!
    @IBOutlet weak var donationAmount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Reconocer el toque para que desaparezca el teclado
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
        
        // Ocultar la barra inferior
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    // Función para realizar el pago al presionar el botón
    @IBAction func makePayment(_ sender: Any) {
        
        // Revisar si se llenó correctamente toda la información
        guard
            let cardNumberText: String = cardNumber.text,
            let ownerNameText: String = ownerName.text,
            let expireMonthText: String = monthCard.text,
            let expireYearText: String = yearCard.text,
            let cvNumberText: String = cvNumber.text,
            let donationAmountText = donationAmount.text
        else {
            let alert = UIAlertController(title: "Información Incompleta", message: "Por favor llene correctamente la información", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Cerrar", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        // Referencia de la base de datos y del usuario activo
        let database = Database.database().reference()
        let user = Auth.auth().currentUser
        
        // Información del Pago
        let payment: [String: Any] = [
            "userId": user?.email as Any,
            "cardNumber": cardNumberText,
            "ownerName": ownerNameText,
            "expireDate": expireMonthText + "/" + expireYearText,
            "donationAmount": donationAmountText
        ]
        
        // Guardar el pago
        database.child("Payments").childByAutoId().setValue(payment)
        
        // Mostrar mensaje cuando se completa
        let alert = UIAlertController(
            title: "¡Gracias!",
            message: "Donación Exitosa",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alert, animated: true, completion: nil)
        
        cardNumber.text = ""
        ownerName.text = ""
        monthCard.text = ""
        yearCard.text = ""
        cvNumber.text = ""
        donationAmount.text = ""
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }

}

// Función auxiliar para el teclado
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
