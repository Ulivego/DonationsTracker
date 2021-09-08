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
    let badgeID: Int
    let description: String
    let name: String
    let type: String
    let requisit: String

    init?(snapshot: DataSnapshot)
    {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let badgeID = value["badgeID"] as? Int,
            let description = value["description"] as? String,
            let name = value["name"] as? String,
            let type = value["type"] as? String,
            let requisit = value["requisit"] as? String
        else {
            return nil
        }
        self.reference = snapshot.ref
        self.key = snapshot.key
        self.badgeID = badgeID
        self.description = description
        self.name = name
        self.type = type
        self.requisit = requisit
    }

    func toAnyObject() -> Any{
        return [
            "badgeID":badgeID,
            "description":description,
            "name":name,
            "type":type,
            "requisit":requisit
        ]
    }
}
