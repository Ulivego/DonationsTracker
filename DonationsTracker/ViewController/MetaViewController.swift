//
//  MetaViewController.swift
//  DonationsTracker
//
//  Created by user194242 on 12/10/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import Firebase
import UIKit

class MetaViewController: UIViewController {
    
    var userInfo: User?
    
    let ref = Database.database().reference()
    private let user = Auth.auth().currentUser
    
    @IBOutlet weak var levelLlb: UILabel!
    @IBOutlet weak var eatingFamiliesLbl: UILabel!
    @IBOutlet weak var totalDonationLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userSnapshot = ref.child("UserProfile").child(user!.uid).observe(.value){ snapshot in
            self.userInfo = User(snapshot: snapshot)
        }
        //print(userInfo!)
        levelLlb.text = userInfo?.level
        eatingFamiliesLbl.text = "\(String(describing: userInfo?.families))"
        totalDonationLbl.text = "\(String(describing: userInfo?.total))"
        
    }
}
