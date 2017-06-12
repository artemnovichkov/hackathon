//
//  ApplicationFetchingService.swift
//  Hackathon
//
//  Created by Evgeny Mikhaylov on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Foundation

final class ApplicationsFetchingService {
    
    func fetchApplications(_ completionHandler: ([Application]) -> Swift.Void) {
        let appTitles = [
            "Calico",
            "RandomChat",
            "Phyzseek",
            "HypeType",
            "Trackd",
            "Beatmix",
            ];
        let applications = appTitles.enumerated().map { offset, title -> Application in
            let application = Application()
            application.uniqueIdentifier = "\(offset)"
            application.title = title
            return application
        }
        completionHandler(applications)
    }
}
