//
//  Badge.swift
//  DonationsTracker
//
//  Created by Ana on 9/8/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import Firebase

struct Badge{
    
    let reference: DatabaseReference?
    let key: String
    let name: String
    let description: String
    let requisit: String

    init?(snapshot: DataSnapshot)
    {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let description = value["description"] as? String,
            let requisit = value["requisit"] as? String
        else {
            return nil
        }
        
        self.reference = snapshot.ref
        self.key = snapshot.key
        self.description = description
        self.name = name
        self.requisit = requisit
        
        print(self.key)
    }

    func toAnyObject() -> Any{
        return [
            "description":description,
            "name":name,
            "requisit":requisit
        ]
    }
}
