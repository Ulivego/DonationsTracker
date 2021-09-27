//
//  UserAuth.swift
//  DonationsTracker
//
//  Created by user194269 on 9/9/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import Firebase

struct UserAuth {
    let userId: String
    let email: String
    
    init(authData: Firebase.User) {
        userId = authData.uid
        email = authData.email ?? ""
        
    }
    
    init(userId: String, email: String) {
        self.userId = userId
        self.email = email
    }
    
}
