//
//  Users.swift
//  DonationsTracker
//
//  Created by Ana on 9/6/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import Firebase

struct Users{
    let email: String
    let firstName: String
    let lastName: String
    let password: String
    let role: String
    let birthDate: Date
    
    init(authData: Firebase.User) {
        email = authData.email ?? ""
        firstName = authData.firstName
        lastName = authData.lastName
        password = authData.password
        role = authData.role
        birthDate = authData.birthDate
    }
    
    init(email: String, firstName: String, lastName: String, password: String, role:String, birthDate: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.role = role
        self.birthDate = birthDate
    }
    
}
