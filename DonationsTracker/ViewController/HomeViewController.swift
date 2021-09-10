//
//  HomeViewController.swift
//  DonationsTracker
//
//  Created by user194269 on 9/7/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var ProductCollection: UICollectionView!
    
    // TODO: Quitar
    let productNames = ["Aceite", "Cereal", "Papel Higienico", "Frijol", "Arroz", "Melon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "Item"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ProductCollectionViewCell
        cell.productLabel.text = productNames[indexPath.row]
        cell.progressBar.progressTintColor = UIColor.red
        cell.progressBar.progressViewStyle = .bar
        cell.progressBar.transform = cell.progressBar.transform.scaledBy(x: 1, y: 8)
        
        return cell
    }
    
    
}
