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
    dynamic var usage: Usage? = Usage()
    
    convenience init(id: Int = 0, name: String?, icon: String?, rank: Int = 0, score: Int = 0, usage: Usage?) {
        self.init()
        self.id = id
        self.name = name
        self.icon = icon
        self.rank = rank
        self.score = score
        self.usage = usage
    }
    
    override class func primaryKey() -> String? {
        return #keyPath(id)
    }
}

extension App: TextOutputStreamable {
    func write<Target>(to target: inout Target) where Target : TextOutputStream {
        print("Name:", name ?? "bla", to: &target)
        print("Rank:", rank, to: &target)
    }
}

class Usage: Object {
    dynamic var users: Int = 0
    dynamic var crashFreeUsers: Double = 0.0
    dynamic var activeUsers: Int = 0
    
    convenience init(users: Int = 0, crashFreeUsers: Double = 0.0, activeUsers: Int = 0) {
        self.init()
        self.users = users
        self.crashFreeUsers = crashFreeUsers
        self.activeUsers = activeUsers
    }
}
