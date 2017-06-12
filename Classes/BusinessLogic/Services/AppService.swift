//
//  AppService.swift
//  Hackathon
//
//  Created by Artem Novichkov on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Alamofire
import Realm
import RealmSwift

final class AppService {
    
    func loadApps(completion: @escaping ([App]) -> Void) {
        let url = URL(string: "http://10.1.0.102")!
        Alamofire
            .request(url, method: .get, encoding: JSONEncoding.default)
            .responseJSON(completionHandler: { dataResponse in
                let json = dataResponse.result.value as! [String: AnyObject]
                completion(self.map(json: json))
            })
    }
    
    func map(json: [String: Any]) -> [App] {
        let rawData = json["apps"] as! [[String: Any]]
        let realm = try! Realm()
        realm.beginWrite()
        let apps = rawData.flatMap { json -> App in
            let app = App()
            if let id = json["id"] as? Int {
                app.id = id
            }
            app.name = json["name"] as? String
            app.icon = json["icon"] as? String
            if let rank = json["rank"] as? Int {
                app.rank = rank
            }
            if let score = json["score"] as? Int {
                app.score = score
            }
            
            let usage = json["usage"] as! [String: AnyObject]
            let newUsers = usage["new_users"] as! Int
            let activeUsers = (usage["active_users"] as! [String: AnyObject])["daily"] as! Int
            let crashFreeUsers = usage["crash_free_users"] as! Double
            app.usage = Usage(users: newUsers, crashFreeUsers: crashFreeUsers, activeUsers: activeUsers)
            
            return app
        }
        realm.add(apps, update: true)
        try! realm.commitWrite()
        return apps
    }
}
