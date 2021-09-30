//
//  GoalsViewController.swift
//  DonationsTracker
//
//  Created by Ana on 9/29/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import Foundation
import FirebaseDatabase

class GoalsViewController:UICollectionViewDelegate, UIViewCollectionViewDataSource, UIViewController{
    
    //vincular el viewCollection
    @IBOutlet var goalsCollectionView: UICollectionView!
    
    var products: [Goals] = []
    
    private let ref = Database.database().reference()
    //var refObservers: [DatabaseHandle] = []
    
    //ref.setValue("Beans") //esta es una forma
    //ref.childByAutoId().setValue(["product":"beans", "quantity":100]) //genera un ID aleatorio
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.child("goals").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data")
            }
            else if snapshot.exists() {
                print("Got data")
                var newGoals: [Goals] = []
                for child in snapshot.children {
                    if
                        let snapshot = child as? DataSnapshot,
                        let goal = Goals(snapshot: snapshot) {
                        print("Goals are being included")
                        newGoals.append(goal)
                }
                    else{
                        print(snapshot.value as Any)
                        print("something went wrong")
                    }
                }
                self.products = newGoals
                self.goalsCollectionView.reloadData()
            }
        }
        
        /*
        database.child("product1").observe( .value, with:{snapshot in
            guard let value = snapshot.value as? [String: Any] else{
                return
            }
            print("Value: \(value)")
        })
        */
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 5; //Hardcodeado de mientras
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let identifier = "Item"
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ProductCollectionViewCell
        let productCell = products[indexPath.row]
        cell.productLabel.text = productCell.product //Ver como dar valor
        cell.donadosLabel.text = productCell.progress
        cell.objetivoLabel.text = productCell.goal
        return cell
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let item = sender as? UICollectionViewCell
        let indexPath = bookCollection.indexPath(for: item!)
        let detailVC = segue.destination as! DetailViewController
        
        detailVC.detailName = bookNames[(indexPath?.row)!]
    }
     */
       
       //Ahorita esto no
       /*
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           ref.observe(.value, with: {snapshot in
               print(snapshot.value as Any)
           })
       }
       */
    
}
