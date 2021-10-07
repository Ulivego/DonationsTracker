//
//  GoalsViewController.swift
//  DonationsTracker
//
//  Created by Ana on 9/29/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import UIKit
import Firebase

class GoalsViewController: UITableViewController {
    
    var products: [Goal] = []
    
    private let ref = Database.database().reference()
    
    private let user = Auth.auth().currentUser;
    
    private var refObservers: [DatabaseHandle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let goals = ref.child("Goals").queryOrdered(byChild: "progress").observe(.value){ snapshot in
            
            var newGoals: [Goal] = []
            for child in snapshot.children {
                if
                    let snapshot = child as? DataSnapshot,
                    let goal = Goal(snapshot: snapshot) {
                    
                    newGoals.append(goal)
                }
                else{
                
                    print("something went wrong")
                }
            }
            self.products = newGoals
            self.tableView.reloadData()

        }
        
        refObservers.append(goals)
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        refObservers.forEach(ref.removeObserver(withHandle:))
        refObservers = []
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item Cell", for: indexPath) as! ProductCell
        
        let goal = products[indexPath.row]
        
        cell.productLabel.text = goal.product //Ver como dar valor
        cell.donadosLabel.text = String(goal.progress)
        cell.objetivoLabel.text = String(goal.goal)
        cell.progressBar.setProgress(Float(goal.progress) / Float(goal.goal) , animated: true)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
      }
    

    @IBAction func tapAddProduct(_ sender: Any) {
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
                    "goal": Int(goalText) as Any
                ]
                self.ref.child("Goals").childByAutoId().setValue(object)
            }
               
        }))
           
        
           
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete
        }
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
                
            products.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
                
            tableView.endUpdates()
        }
    }
}
