//
//  IndexRequestHandler.swift
//  Hackathon-spotlight
//
//  Created by Evgeny Mikhaylov on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import CoreSpotlight
import MobileCoreServices

class IndexRequestHandler: CSIndexExtensionRequestHandler {

    let appsService = AppService()
    let spotlightService = SpotlightService()

    override func searchableIndex(_ searchableIndex: CSSearchableIndex,
                                  reindexAllSearchableItemsWithAcknowledgementHandler acknowledgementHandler: @escaping () -> Void) {
        appsService.loadApps { [unowned self] apps in
            self.spotlightService.indexApplications(apps, completionHandler: { _ in
                acknowledgementHandler()
            })
        }
    }
    
    override func searchableIndex(_ searchableIndex: CSSearchableIndex,
                                  reindexSearchableItemsWithIdentifiers identifiers: [String],
                                  acknowledgementHandler: @escaping () -> Void) {
        appsService.loadApps { [unowned self] apps in
            let filteredApplications = apps.filter { identifiers.contains(String($0.id)) }
            self.spotlightService.deleteAndIndexApplications(filteredApplications, completionHandler: { _ in
                acknowledgementHandler()
            })
        }
    }
}
