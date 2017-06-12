//
//  MainViewController.swift
//  Hackathon
//
//  Created by Artem Novichkov on 10/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import TableViewTools
import CoreSpotlight
import MobileCoreServices

final class Application {
    
    let title: String
    
    init(title: String) {
        self.title = title
    }
}

class MainViewController: UIViewController {
    
    var tableViewManager: TableViewManager!
    let tableView = UITableView()
    let apps = [
        Application(title: "Calico"),
        Application(title: "RandomChat"),
        Application(title: "Phyzseek"),
        Application(title: "HypeType"),
        Application(title: "Trackd"),
        Application(title: "Beatmix")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchableItems = apps.enumerated().map { (offset, application) -> CSSearchableItem in
            let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            attributeSet.title = application.title
            attributeSet.contentDescription = "Rosberry Application"
            attributeSet.phoneNumbers = ["+79514032124"]
            attributeSet.supportsPhoneCall = true
//            attributeSet.thumbnailData = DocumentImage.jpg
            return CSSearchableItem(uniqueIdentifier: "\(offset)",
                domainIdentifier: "com.rosberryhackathon",
                attributeSet: attributeSet)
        }
        CSSearchableIndex.default().deleteAllSearchableItems { error in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print("Items deleted.")
            }
            CSSearchableIndex.default().indexSearchableItems(searchableItems) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
                else {
                    print("Items indexed.")
                }
            }
        }
        
        tableViewManager = TableViewManager(tableView: tableView)
        tableViewManager.sectionItems = [testAppSectionItem()]
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
        
    func testAppSectionItem() -> TableViewSectionItem {
        let cellItems = apps.map { application -> TableViewCellItemProtocol in
            let cellItem = AppTableViewCellItem(title: application.title)
            cellItem.itemDidSelectHandler = { [unowned self] tableView, indexPath in
                tableView.deselectRow(at: indexPath, animated: true)
                let viewController = DetailViewController(application: application)
                self.show(viewController, sender: nil)
            }
            return cellItem
        }
        return TableViewSectionItem(cellItems: cellItems)
    }

    override func restoreUserActivityState(_ activity: NSUserActivity) {
        if activity.activityType == CSSearchableItemActionType, let userInfo = activity.userInfo {
            let uniqueIdentifier = userInfo[CSSearchableItemActivityIdentifier]
        }
    }
    
}
