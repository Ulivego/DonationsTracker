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
    var userInfo: User?
    
    private var refObservers: [DatabaseHandle] = []
    
    //Takes the values from the database
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
            self.products.sort(by: self.sortProgress)
            self.tableView.reloadData()

        }
        
        refObservers.append(goals)
        
        
        ref.child("UserProfile").child(user!.uid).observe(.value){ snapshot in
            
            self.userInfo = User(snapshot: snapshot)
            
            //Si es admin el botón para agregar productos/metas estará disponible
            if self.userInfo?.userType != "Admin" {
                self.navigationItem.rightBarButtonItems?[1].isEnabled = false
                self.navigationItem.rightBarButtonItems?[1].tintColor = UIColor.white
            } else {
                self.navigationItem.rightBarButtonItems?[1].isEnabled = true
                self.navigationItem.rightBarButtonItems?[1].tintColor = UIColor.systemBlue
            }
        }
        
    }
    
    //Adds and shpws the navigation bar to the view
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        navigationController?.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    //Removes the observers when the view disappears
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        refObservers.forEach(ref.removeObserver(withHandle:))
        refObservers = []
    }
    
    //Returns the number of products/cells/rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    //Shows on screen the products/goals one per row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item Cell", for: indexPath) as! ProductCell
        
        
        let goal = products[indexPath.row]
        
        //Texto de cada celda
        cell.productLabel.text = goal.product
        cell.donadosLabel.text = String(goal.progress) + " kg"
        cell.objetivoLabel.text = String(goal.goal) + " kg"
        
        // Agregar colores alternados a las barras
        if(indexPath.row % 2 == 0){
            cell.progressBar.progressTintColor = UIColor(red: 252/255, green: 161/255, blue: 47/255, alpha: 1)
        } else{
            cell.progressBar.progressTintColor = UIColor(red: 247/255, green: 0/255, blue: 56/255, alpha: 1)
        }
        cell.progressBar.trackTintColor = UIColor.white.withAlphaComponent(0.1)
        
        // Aumentar el tamaño de las barras
        cell.progressBar.bounds.size = CGSize(width: cell.progressBar.bounds.width, height: 16)
 
        // Formato redondeado
        cell.progressBar.layer.cornerRadius = 8
        
        // Actualizar el progreso
        cell.progressBar.setProgress(Float(goal.progress) / Float(goal.goal) , animated: true)
        
        // Si la meta es completada, es necesario borrar la vista de la meta
        if goal.progress >= goal.goal {
            let toDelete = self.ref.child("Goals").child(products[indexPath.row].key)
            toDelete.removeValue { error, _ in
                print(error?.localizedDescription as Any)
            }
            products.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        return cell
    }
    
    //Gives permission to edit the row
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
      }
    
    //When "Agregar Producto" is pressed it creates an alert in which you can give input
    //the product and the goal. After pressing accept it creates a new cell
    @IBAction func tapAddProduct(_ sender: Any) {
        let alert = UIAlertController(title: "Crear Meta", message: "Anota la información de la nueva meta", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Nombre del Producto"
            textField.autocapitalizationType = .words
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Ingresa el Objetivo"
            textField.autocapitalizationType = .words
        }
           
        var object: [String: Any] = [:]
        alert.addAction(UIAlertAction(title: "Guardar", style: .default, handler: { [weak alert] (_) in
            if
                //Toma el input de los campos de la alerta
                let textFieldProduct = alert?.textFields?[0],
                let productText = textFieldProduct.text,
                let textFieldGoal = alert?.textFields?[1],
                let goalText = textFieldGoal.text {
                
                //Crea objeto diccionario del producto/meta
                object = [
                    "product": productText,
                    "progress": 0,
                    "goal": Int(goalText) as Any
                ]
                if(goalText != "" || productText != ""){
                    self.ref.child("Goals").childByAutoId().setValue(object)
                } else{
                    let notCreated = UIAlertController(title: "Acción Fallida", message: "Alguno de los campos estaba vacío. No se pudo crear la meta.", preferredStyle: .alert)
                    notCreated.addAction(UIAlertAction(title: "Cerrar", style: .default))
                    self.present(notCreated, animated: true)
                }
            }
               
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //Changes the editing style of the cell to delete so that it may be erased
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if userInfo?.userType != "Admin" { return .none }
        
            return .delete
        }
    
    //Deletes the product cell and data when swiped to the left
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //Tiene que ser tipo de usuario admin para eliminar
        if userInfo?.userType == "Admin" {
            if editingStyle == .delete {
                tableView.beginUpdates()
                
                let toDelete = self.ref.child("Goals").child(products[indexPath.row].key)
                toDelete.removeValue { error, _ in
                    print(error?.localizedDescription as Any)
                }
                    
                products.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                    
                tableView.endUpdates()
            }
        }
    }
    
    //Used to sort the Progress related to the goal of the products
    func sortProgress(this: Goal, that: Goal) -> Bool {
        let value1 = Float(this.progress) / Float(this.goal)
        let value2 = Float(that.progress) / Float(that.goal)
        return value1 < value2
    }
    
}
