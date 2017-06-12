//
//  App.swift
//  Hackathon
//
//  Created by Artem Novichkov on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Foundation

class App {
    
    let id: Int
    let name: String
    let icon: String
    let rank: Int
    let score: Int
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let icon = json["icon"] as? String,
            let rank = json["rank"] as? Int,
            let score = json["score"] as? Int
            else {
                return nil
        }
        self.id = id
        self.name = name
        self.icon = icon
        self.rank = rank
        self.score = score
    }
}
