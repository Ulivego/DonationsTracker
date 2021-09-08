//
//  EarnedBadges.swift
//  DonationsTracker
//
//  Created by Ana on 9/8/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import Firebase

struct EarnedBadges{
    let reference: DatabaseReference?
    let key: String
    let badgeID: Int
    let userID: Int
    let dateEarned: Date
    let earned: Bool

    init?(snapshot: DataSnapshot)
    {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let badgeID = value["badgeID"] as? Int,
            let userID = value["userId"] as? Int,
            let dateEarned = value["dataEarned"] as? Date,
            let earned = value["earned"] as? Bool
        else {
            return nil
        }
        self.reference = snapshot.ref
        self.key = snapshot.key
        self.badgeID = badgeID
        self.userID = userID
        self.dateEarned = dateEarned
        self.earned = earned
    }

    func toAnyObject() -> Any{
        return [
            "badgeID":badgeID,
            "userID":userID,
            "dateEarned":dateEarned,
            "earned":earned
        ]
    }
}
