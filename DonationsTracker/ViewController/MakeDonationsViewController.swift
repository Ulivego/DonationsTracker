//
//  MakeDonationsViewController.swift
//  DonationsTracker
//
//  Created by user194269 on 9/1/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import UIKit

class MakeDonationsViewController: UIViewController {
    
    // URL de la página de Donaciones en Especie
    let donationsPage = "https://bdalimentos.org/dona-en-especie/"
    
    // Botón de "Donaciones en Especie"
    @IBAction func SpeciesDonBtn(_ sender: Any) {
        if let url = URL(string: donationsPage) {
            UIApplication.shared.open(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}
