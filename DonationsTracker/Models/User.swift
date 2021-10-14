//
//  User.swift
//  DonationsTracker
//
//  Created by Ana on 9/8/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import Firebase

struct User{
    //let name: String?
    //let lastName: String?
    let level: String?
    let total: Int?
    let families: Int?
    //let birthday : String?
    let logros: [Bool]?
    
    init?(snapshot: DataSnapshot) {
        //print(snapshot)
        
        guard
            let value = snapshot.value as? NSDictionary,
            //let name = value["name"] as? String,
            //let lastName = value["lastName"] as? String,
            let level = value["level"] as? String,
            let total = value["donations"] as? Int,
            let families = value["families"] as? Int
            //let birthday = value["birthDate"] as? String,
        else {
            print("F")
            return nil
        }
        
        var newLogros:[String:  Any] = [:]
        for child in value["logros"] as! [String: Any] {
            if let logro = child as? DataSnapshot {
                //newLogros = child
                //print(value["logros"])
            }
        }
        
        //print (value["logros"])
        //self.name = name
        //self.lastName = lastName
        self.level = level
        self.total = total
        self.families = families
        //self.birthday = birthday
        self.logros = []
    }
    
    
}
