//
//  MakeDonationsViewController.swift
//  DonationsTracker
//
//  Created by user194269 on 9/1/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import UIKit
import Firebase

class MakeDonationsViewController: UIViewController {

    private let database = Database.database().reference()
    let donationsPage = "https://bdalimentos.org/dona-en-especie/"
    
    @IBAction func SpeciesDonBtn(_ sender: Any) {
        if let url = URL(string: donationsPage) {
            UIApplication.shared.open(url)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    


}
