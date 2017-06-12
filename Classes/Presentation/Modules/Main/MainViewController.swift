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
    var apps = [App]()
    
    let appService = AppService()
    let spotlightService = SpotlightService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        self.tableViewManager = TableViewManager(tableView: self.tableView)
        self.tableViewManager.sectionItems = []

        appService.loadApps { [unowned self] apps in
            self.apps = apps
            self.tableViewManager.sectionItems = [self.testAppSectionItem()]
            self.view.addSubview(self.tableView)
            self.spotlightService.deleteAndIndexApplications(apps)
        }
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()        
        tableView.frame = view.bounds
    }
    
    func testAppSectionItem() -> TableViewSectionItem {
        let cellItems = apps.map { application -> TableViewCellItemProtocol in
            let cellItem = AppTableViewCellItem(title: application.name ?? "App Name")
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
            if apps.count > 0 {
                openApp(withIdentifier: uniqueIdentifier)
            }
            else {
                appService.loadApps { [unowned self] apps in
                    self.apps = apps
                    self.openApp(withIdentifier: uniqueIdentifier)
                }
            }
        }
    }
    
    func openApp(withIdentifier identifier: String) {
        let application = apps.filter { String($0.id) == identifier }.first
        if let application = application {
            let viewController = DetailViewController(application: application)
            self.navigationController?.popViewController(animated: false)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func showAlert(withMessage message: String) {
        let alertController = UIAlertController(title: "Hackathon", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

extension MainViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                           viewControllerForLocation location: CGPoint) -> UIViewController? {
        let point = view.convert(location, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point)
            else { return nil }
        let application = apps[indexPath.row]
        let vc = DetailViewController(application: application)
        vc.favouriteHandler = { [weak self] app in
            self?.showAlert(withMessage: "App \(app.name!) has been successfully added to favourites.")
        }
        vc.deleteHandler = { [weak self] app in
            self?.showAlert(withMessage: " Tracking of \(app.name!) app has been stopped.")
        }
        return vc
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                           commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: nil)
    }
}
