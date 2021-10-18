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
    
    // Identificador de las Celdas de Insignias
    let reuseIdentifier = "LogroCell"
    
    // Collection View para las insignias
    @IBOutlet weak var logrosCollection: UICollectionView!
    
    // Información del Usuario
    var userInfo: User?
    
    // Información de los Logros (Nombre, Descripción y Requisito)
    var logros: [Badge] = []
    
    // Referencia a la Base de Datos
    let ref = Database.database().reference()
    
    // Referencia al Usuario Activo
    private let user = Auth.auth().currentUser
    
    // Observadores para los objetos de Firebase
    private var refObservers: [DatabaseHandle] = []
    
    // Etiquetas de UI sobre la información del Usuario
    @IBOutlet weak var levelLlb: UILabel!
    @IBOutlet weak var eatingFamiliesLbl: UILabel!
    @IBOutlet weak var totalDonationLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Obtener la información del usuario activo
        ref.child("UserProfile").child(user!.uid).observe(.value){ snapshot in
            self.userInfo = User(snapshot: snapshot)
            
            // Mostrar la información del Usuario
            self.levelLlb.text = self.userInfo?.level!
            self.eatingFamiliesLbl.text = String("\((self.userInfo?.families)!) Familias")
            self.totalDonationLbl.text = String("$ \((self.userInfo?.total)!)")
        }
        
        // Obtener los logros existentes
        let logrosHandlers = ref.child("Logros").observe(.value) { snapshot in
            
            var badges: [Badge] = []
            
            for child in snapshot.children {
                // Crear la insginia para cada logro y guardarla
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
        
        // Borrar las referencias para evitar leaks
        refObservers.forEach(ref.removeObserver(withHandle:))
        refObservers = []
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return logros.count
    }
    
    // Actualizar la celda cada que la UI lo requiera
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Recicla una vista de celda, de tipo LogroViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LogroViewCell
        
        // Asignar el nombre de la insignia
        cell.Name.text = logros[indexPath.row].name
        cell.Name.textAlignment = .center
        
        // Asigna la imagen de la insignia
        if(userInfo?.logros?[indexPath.row] == false) {
            // Si el usuario no ha logrado esa insignia, se muestra como bloqueada
            cell.LogroImage.image = UIImage(named: "Logo_BAG_manzana")?.withRenderingMode(.alwaysTemplate)
            cell.LogroImage.tintColor = UIColor.gray
        } else {
            cell.LogroImage.image = UIImage(named: "Logo_BAG_manzana")
        }
        
        return cell
        
    }
    
    // Cuando se selecciona una celda
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Obtener la información de la insignia correspondiente a la celda seleccionada
        let logro = logros[indexPath.row]
        
        // Crear una alerta con la descripción de la insignia
        let logroDescriptionAlert = UIAlertController(title: logro.name, message: logro.description, preferredStyle: .alert)
        
        // Si la insignia no ha sido adquirida por el usuario, esta mostrará el requisito en lugar de la descripción
        if(userInfo?.logros?[indexPath.row] == false) {
            logroDescriptionAlert.message = "Requisito: \(logro.requisit)"
        }
        logroDescriptionAlert.addAction(UIAlertAction(title: "Cerrar", style: .default))
        
        self.present(logroDescriptionAlert, animated: true, completion: nil)
    }
}
