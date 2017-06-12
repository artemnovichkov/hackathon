//
//  TodayViewController.swift
//  hackathon-today
//
//  Created by Artem Novichkov on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import NotificationCenter
import TableViewTools
import RealmSwift

@objc (TodayViewController)
class TodayViewController: UIViewController {
        
    let tableView = UITableView()
    var tableViewManager: TableViewManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableViewManager = TableViewManager(tableView: tableView)
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        RealmService.configureRealm()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func loadData() {
        let realm = try! Realm()
        let apps = realm.objects(App.self).array
        tableViewManager.sectionItems = [sectionItem(for: apps)]
    }
    
    func sectionItem(for apps: [App]) -> TableViewSectionItemProtocol {
        let cellItems = apps.map { app -> TableViewCellItemProtocol in
            let item = AppTableViewCellItem(app: app)
            item.itemDidSelectHandler = { [unowned self] _, _ in
                self.open(app: app)
            }
            return item
        }
        return TableViewSectionItem(cellItems: cellItems)
    }
    
    func open(app: App) {
        let url = URL(string: "hackathon://\(app.id)")!
        extensionContext?.open(url, completionHandler: { success in
            print(success)
        })
    }
}

extension TodayViewController: NCWidgetProviding {
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        loadData()
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let expanded = activeDisplayMode == .expanded
        preferredContentSize = expanded ? CGSize(width: maxSize.width, height: 200) : maxSize
        tableView.reloadData()
    }
}

extension Results {
    
    var array: [T] {
        var objects = [T]()
        forEach { object in
            objects.append(object)
        }
        return objects
    }
}
