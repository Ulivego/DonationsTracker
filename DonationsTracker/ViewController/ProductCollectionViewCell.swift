//
//  ProductCollectionViewCell.swift
//  DonationsTracker
//
//  Created by user193315 on 9/9/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import UIKit
import FirebaseDatabase


// Vista de la Celda de las Metas
class ProductCell: UITableViewCell{
    
    // Nombre del producto
    @IBOutlet weak var productLabel: UILabel!
    
    // Progreso actual de la meta
    @IBOutlet weak var donadosLabel: UILabel!
    
    // Barra de Progreso
    @IBOutlet weak var progressBar: UIProgressView!
    
    // Objetivo de la meta
    @IBOutlet weak var objetivoLabel: UILabel!
    
}
