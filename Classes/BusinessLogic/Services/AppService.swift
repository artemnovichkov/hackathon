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
            .response { response in
                let object = try! JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! [String: Any]
                completion(self.map(json: object))
        }
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
            return app
        }
        realm.add(apps, update: true)
        try! realm.commitWrite()
        return apps
    }
}
