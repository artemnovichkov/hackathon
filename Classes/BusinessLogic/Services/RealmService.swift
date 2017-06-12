//
//  RealmService.swift
//  Hackathon
//
//  Created by Artem Novichkov on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Realm

class RealmService {
    
    static func configureRealm() {
        var url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.rosberry.hackathon")!
        url.appendPathComponent("db.realm")
        let configuration = RLMRealmConfiguration.default()
        configuration.fileURL = url
        RLMRealmConfiguration.setDefault(configuration)
    }
}
