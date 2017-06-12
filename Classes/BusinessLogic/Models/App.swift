//
//  App.swift
//  Hackathon
//
//  Created by Artem Novichkov on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Foundation
import RealmSwift

class App: Object {
    
    dynamic var id: Int = 0
    dynamic var name: String?
    dynamic var icon: String?
    dynamic var rank: Int = 0
    dynamic var score: Int = 0
    
    convenience init(id: Int = 0, name: String?, icon: String?, rank: Int = 0, score: Int = 0) {
        self.init()
        self.id = id
        self.name = name
        self.icon = icon
        self.rank = rank
        self.score = score
    }
    
    override class func primaryKey() -> String? {
        return #keyPath(id)
    }
}
