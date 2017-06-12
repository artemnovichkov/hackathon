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

class MainViewController: UIViewController {
    
    var tableViewManager: TableViewManager!
    let tableView = UITableView()
    var applications = [Application]()
    
    let applicationFetchingService = ApplicationsFetchingService()
    let spotlightService = SpotlightService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applicationFetchingService.fetchApplications { [unowned self] applications in
            self.applications = applications
//            self.spotlightService.deleteAndIndexApplications(applications)
            self.tableViewManager = TableViewManager(tableView: self.tableView)
            self.tableViewManager.sectionItems = [self.testAppSectionItem()]
            self.view.addSubview(self.tableView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
        
    func testAppSectionItem() -> TableViewSectionItem {
        let cellItems = applications.map { application -> TableViewCellItemProtocol in
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
            guard let uniqueIdentifier = userInfo[CSSearchableItemActivityIdentifier] as? String else {
                return
            }
            applicationFetchingService.fetchApplications { [unowned self] applications in
                self.applications = applications
                let application = applications.filter { $0.uniqueIdentifier == uniqueIdentifier }.first
                if let application = application {
                    let viewController = DetailViewController(application: application)
                    self.navigationController?.popViewController(animated: false)
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
        }
    }
    
}
