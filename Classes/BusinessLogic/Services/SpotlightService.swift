//
//  SpotlightService.swift
//  Hackathon
//
//  Created by Evgeny Mikhaylov on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Foundation
import CoreSpotlight
import MobileCoreServices

final class SpotlightService {

    func deleteAndIndexApplications(_ applications: [Application], completionHandler: ((Error?) -> Swift.Void)? = nil) {
        CSSearchableIndex.default().deleteAllSearchableItems { [unowned self] error in
            if let error = error {
                if let completionHandler = completionHandler {
                    completionHandler(error)
                }
            }
            else {
                self.indexApplications(applications, completionHandler: completionHandler)
            }
        }
    }
    
    func indexApplications(_ applications: [Application], completionHandler: ((Error?) -> Swift.Void)? = nil) {
        let searchableItems = applications.map { application -> CSSearchableItem in
            let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            attributeSet.title = application.title
            attributeSet.contentDescription = "Rosberry Application"
            attributeSet.phoneNumbers = ["+79514032124"]
            attributeSet.supportsPhoneCall = true
            //            attributeSet.thumbnailData = DocumentImage.jpg
            return CSSearchableItem(uniqueIdentifier: application.uniqueIdentifier,
                                    domainIdentifier: "com.rosberry.hackathon",
                                    attributeSet: attributeSet)
        }
        CSSearchableIndex.default().indexSearchableItems(searchableItems, completionHandler: completionHandler)
    }
    
}
