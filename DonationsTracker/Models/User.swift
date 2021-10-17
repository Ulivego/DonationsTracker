//
//  User.swift
//  DonationsTracker
//
//  Created by Ana on 9/8/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import Firebase

struct User{
    let name: String?
    let lastName: String?
    let level: String?
    let total: Int?
    let families: Int?
    let logros: [Bool]?
    
    init?(snapshot: DataSnapshot) {

        guard
            let value = snapshot.value as? NSDictionary,
            let name = value["name"] as? String,
            let lastName = value["lastName"] as? String,
            let level = value["level"] as? String,
            let total = value["donations"] as? Int,
            let families = value["families"] as? Int,
            let logros = value["logros"] as? [String: Bool]

        else {

            return nil
        }
        
        let earned = logros.map { (key: String, value: Bool) -> Bool in
            return value
        }
        
        self.name = name
        self.lastName = lastName
        self.level = level
        self.total = total
        self.families = families
        self.logros = earned
    }
    
    
}
