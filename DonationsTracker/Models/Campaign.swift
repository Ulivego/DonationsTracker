//
//  Campaign.swift
//  DonationsTracker
//
//  Created by Ana on 9/7/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import Firebase

struct Campaign{
    let reference: DatabaseReference?
    let key: String
    let campaignID: Int
    let month: Date
    let limit: Int
    let progress: Int
    let imageURL: String
    let platformURL: String

    init?(snapshot: DataSnapshot)
    {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let campaignID = value["campaignID"] as? Int,
            let month = value["month"] as? Date,
            let limit = value["limit"] as? Int,
            let progress = value["progress"] as? Int,
            let imageURL = value["imageURL"] as? String,
            let platformURL = value["platformURL"] as? String
        else {
            return nil
        }
        self.reference = snapshot.ref
        self.key = snapshot.key
        self.campaignID = campaignID
        self.month = month
        self.limit = limit
        self.progress = progress
        self.imageURL = imageURL
        self.platformURL = platformURL
    }

    func toAnyObject() -> Any{
        return [
            "campaignID":campaignID,
            "month":month,
            "limit":limit,
            "progress":progress,
            "imageURL":imageURL,
            "platformURL":platformURL
        ]
    }
}
