//
//  AppService.swift
//  Hackathon
//
//  Created by Artem Novichkov on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Alamofire

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
        return rawData.flatMap { json in
            return App(json: json)
        }
    }
}
