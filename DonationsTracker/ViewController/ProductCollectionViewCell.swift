//
//  ProductCollectionViewCell.swift
//  DonationsTracker
//
//  Created by user193315 on 9/9/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProductCollectionViewCell:UICollectionViewCell{
    
    @IBOutlet weak var productLabel: UILabel!
    
    @IBOutlet weak var donadosLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var objetivoLabel: UILabel!
    
}

/*
 private let ref = Database.database().reference()
    //var refObservers: [DatabaseHandle] = []
    
    //ref.setValue("Beans") //esta es una forma
    //ref.childByAutoId().setValue(["product":"beans", "quantity":100]) //genera un ID aleatorio
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database.child("product1").observe( .value, with:{snapshot in
            guard let value = snapshot.value as? [String: Any] else{
                return
            }
            print("Value: \(value)")
        })
    }
    
    @IBAction func tapAddProduct(_ sender: UIButton) {
        let alert = UIAlertController(title: "Save product", message: "Guardar Producto", preferredStyle: .alert)
        alert.addtextField { (textField) in textField.placeholder = "Enter the products name"}
        alert.addtextField { (textField) in textField.placeholder = "Enter the goal"}
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            if let textField = alert?.textFields?[0], let productText = textField.text {
                print("User text: \(productText)")
            }

            if let textField = alert?.textFields?[1], let goalText = textField.text {
                print("User text 2: \(goalText)")
            }
            
            /*
            let product = Product(
                product: productText,
                goal: goalText
            )
 */
            
            //Estas dos la verdad no estoy seguro
            /*
            let productRef = self.ref.child(text.lowercased())
            productRef.setValue(product.toAnyObject())
            */
        }))
        
        //Video iOS Academy //probando fuera del alert
        let object: [String: Any] = [
            "product": productText,
            "progress": 0,
            "goal": goalText
        ]
        database.child("goals").childByAutoId().setValue(object)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    func addItemDidTouch(_:){
        /*
        let saveAction = UIAlertAction(title: "Save", style: .default) {_ in
            guard
                let textField = alert.textFields?.first,
                let text = textField.text,
                let user = self.user
            else {return}
            
            let product = Product(
                donationID: Int,
                donatedBy: user.email,
                type: String,
                product: text,
                donation: Double,
                date: Date
            )
        }
        */
        
    }
 */
    
    
    //Ahorita esto no
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ref.observe(.value, with: {snapshot in
            print(snapshot.value as Any)
        })
    }
 */
