//
//  goalsModel.swift
//  DonationsTracker
//
//  Created by Ana on 9/30/21.
//  Copyright © 2021 Team5. All rights reserved.
//

import Firebase

struct Goal {
    let reference: DatabaseReference?
    let key: String
    let product: String
    let progress: Double
    let goal: Double
    
    init(product: String, progress: Double, goal: Double, key: String = ""){
        self.reference = nil
        self.key = key
        self.product = product
        self.progress = progress
        self.goal = goal
    }

    init?(snapshot: DataSnapshot)
    {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let product = value["product"] as? String,
            let progress = value["progress"] as? Double,
            let goal = value["goal"] as? Double
        else {
            return nil
        }
        self.reference = snapshot.ref
        self.key = snapshot.key
        self.product = product
        self.progress = progress
        self.goal = goal
    }

    func toAnyObject() -> Any{
        return [
            "product":product,
            "progress":progress,
            "goal":goal
        ]
    }
}
