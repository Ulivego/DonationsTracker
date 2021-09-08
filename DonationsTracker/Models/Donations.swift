//
//  Donations.swift
//  DonationsTracker
//
//  Created by Ana on 9/7/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import Firebase

struct Donations{
    let reference: DatabaseReference?
    let key: String
    let donationID: Int
    let donatedBy: Int //int?
    let type: String
    let product: String
    let donation: Double
    let date: Date

    init?(snapshot: DataSnapshot)
    {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let donationID = value["donationID"] as? Int,
            let donatedBy = value["donatedBy"] as? Int,
            let type = value["type"] as? String,
            let product = value["product"] as? String,
            let donation = value["donation"] as? Double,
            let date = value["date"] as? Date
        else {
            return nil
        }
        self.reference = snapshot.ref
        self.key = snapshot.key
        self.donationID = donationID
        self.donatedBy = donatedBy
        self.type = type
        self.product = product
        self.donation = donation
        self.date = date
    }

    func toAnyObject() -> Any{
        return [
            "donationID":donationID,
            "donatedBy":donatedBy,
            "type":type,
            "product":product,
            "donation":donation,
            "date":date
        ]
    }
}
