//
//  GoalsViewController.swift
//  DonationsTracker
//
//  Created by Ana on 9/29/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import UIKit
import FirebaseDatabase

class GoalsViewController:
    UICollectionViewController {
    
    //vincular el viewCollection
    @IBOutlet var goalsCollectionView: UICollectionView!
    
    var products: [Goal] = []
    
    private let ref = Database.database().reference()
    
    //var refObservers: [DatabaseHandle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        print("Hello")
        
        ref.child("Goals").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data")
            }
            else if snapshot.exists() {
                print("Got data")
                var newGoals: [Goal] = []
                for child in snapshot.children {
                    if
                        let snapshot = child as? DataSnapshot,
                        let goal = Goal(snapshot: snapshot) {
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 5; //Hardcodeado de mientras
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> ProductCollectionViewCell {
        let identifier = "Item"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ProductCollectionViewCell
        
        let goal = products[indexPath.row]
        
        cell.productLabel.text = goal.product //Ver como dar valor
        cell.donadosLabel.text = String(goal.progress)
        cell.objetivoLabel.text = String(goal.goal)
        
        return cell
    }
    
    @IBAction func tapAddProduct(_ sender: UIButton) {
        let alert = UIAlertController(title: "Save product", message: "Guardar Producto", preferredStyle: .alert)
        
        alert.addTextField { (textField) in textField.placeholder = "Enter the products name"}
        alert.addTextField { (textField) in textField.placeholder = "Enter the goal"}
           
        var object: [String: Any] = [:]
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            if
                let textFieldProduct = alert?.textFields? [0],
                let productText = textFieldProduct.text,
                let textFieldGoal = alert?.textFields?[1],
                let goalText = textFieldGoal.text {
                
                object = [
                    "product": productText,
                    "progress": 0,
                    "goal": goalText
                ]
                
                print("User text: \(productText)")
            }
               
        }))
           
        self.ref.child("Goals").childByAutoId().setValue(object)
           
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
