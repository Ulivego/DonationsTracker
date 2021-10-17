//
//  MetaViewController.swift
//  DonationsTracker
//
//  Created by user194242 on 12/10/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import Firebase
import UIKit

class MetaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    let reuseIdentifier = "LogroCell"
    
    @IBOutlet weak var logrosCollection: UICollectionView!
    
    var userInfo: User?
    var logros: [Badge] = []
    
    let ref = Database.database().reference()
    private let user = Auth.auth().currentUser
    
    private var refObservers: [DatabaseHandle] = []
    
    @IBOutlet weak var levelLlb: UILabel!
    @IBOutlet weak var eatingFamiliesLbl: UILabel!
    @IBOutlet weak var totalDonationLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref.child("UserProfile").child(user!.uid).observe(.value){ snapshot in
            self.userInfo = User(snapshot: snapshot)
            
            self.levelLlb.text = self.userInfo?.level!
            self.eatingFamiliesLbl.text = String((self.userInfo?.families)!)
            self.totalDonationLbl.text = String("$ \((self.userInfo?.total)!)")
        }
        
        let logrosHandlers = ref.child("Logros").observe(.value) { snapshot in
            
            var badges: [Badge] = []
            
            for child in snapshot.children {
                if
                    let logro = child as? DataSnapshot,
                    let badge = Badge(snapshot: logro) {
                    
                    badges.append(badge)
                }
                else {
                    print("something went wrong")
                }
            }
            
            self.logros = badges
            self.logrosCollection.reloadData()
    
        }
        
        refObservers.append(logrosHandlers)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        refObservers.forEach(ref.removeObserver(withHandle:))
        refObservers = []
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return logros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LogroViewCell
        
        cell.Name.text = logros[indexPath.row].name
        cell.Name.textAlignment = .center
        
        if(userInfo?.logros?[indexPath.row] == false) {
            cell.LogroImage.tintColor = UIColor.gray
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let logro = logros[indexPath.row]
        
        let logroDescriptionAlert = UIAlertController(title: logro.name, message: logro.description, preferredStyle: .alert)
        
        if(userInfo?.logros?[indexPath.row] == false) {
            logroDescriptionAlert.message = "Requisito: \(logro.requisit)"
        }
        logroDescriptionAlert.addAction(UIAlertAction(title: "Cerrar", style: .default))
        
        self.present(logroDescriptionAlert, animated: true, completion: nil)
    }
}
