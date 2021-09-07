//
//  EarnedBadge.swift
//  DonationsTracker
//
//  Created by Ana on 9/7/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import Foundation

struct EarnedBadge{
    let reference: DatabaseReference?

    init?(snapshot: DataSnapshot)
    {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let email = value["email"] as? String,
            let firstName = value["firstName"] as? String,
            let lastName = value["lastName"] as? String,
            let password = value["password"] as? String,
            let role = value["role"] as? String,
            let birthDate = value["birthDate"] as? String
        else {
            return nil
        }
        self.reference = snapshot.ref
        self.key = snapshot.key
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.role = role
        self.birthDate = birthDate
    }

    func toAnyObject() -> Any{
        return [
            "email":email,
            "firstName":firstName,
            "lastName":lastName,
            "password":password,
            "role":role,
            "birthDate":birthDate
        ]
    }
}
