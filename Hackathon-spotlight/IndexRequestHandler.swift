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

    let applicationFetchingService = ApplicationsFetchingService()
    let spotlightService = SpotlightService()

    override func searchableIndex(_ searchableIndex: CSSearchableIndex,
                                  reindexAllSearchableItemsWithAcknowledgementHandler acknowledgementHandler: @escaping () -> Void) {
        applicationFetchingService.fetchApplications { [unowned self] applications in
            self.spotlightService.deleteAndIndexApplications(applications, completionHandler: { _ in
                acknowledgementHandler()
            })
        }
    }
    
    override func searchableIndex(_ searchableIndex: CSSearchableIndex,
                                  reindexSearchableItemsWithIdentifiers identifiers: [String],
                                  acknowledgementHandler: @escaping () -> Void) {
        applicationFetchingService.fetchApplications { [unowned self] applications in
            self.spotlightService.deleteAndIndexApplications(applications, completionHandler: { _ in
                acknowledgementHandler()
            })
        }
    }
}
