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
    let lastName: String?
    let level: String?
    let total: Int?
    let families: Int?
    //let birthday : Date?
    //let logros: [Bool]?
    
    init?(snapshot: DataSnapshot) {
        print(snapshot)
        guard let value = snapshot.value as? NSDictionary,
            //let name = value["name"] as? String,
            let lastName: String? = value["lastName"] as? String ?? "1",
            let level: String? = value["level"] as? String ?? "1",
            let total: Int? = value["donations"] as? Int ?? 1,
            let families: Int? = value["families"] as? Int ?? 1
            //let birthday = value["birthDate"] as? Date
            //let logros = value["logros"] as? [Bool]
        else {
            return nil
        }
        //self.name = name
        self.lastName = lastName
        self.level = level
        self.total = total
        self.families = families
        //self.birthday = birthday
        //self.logros = logros
    }
    
    
}
