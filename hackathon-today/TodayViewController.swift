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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func loadData() {
        tableViewManager.sectionItems = [sectionItem()]
    }
    
    func sectionItem() -> TableViewSectionItemProtocol {
        let cellItems = [AppTableViewCellItem(),
                         AppTableViewCellItem(),
                         AppTableViewCellItem(),
                         AppTableViewCellItem()]
        cellItems.forEach { item in
            item.itemDidSelectHandler = { [unowned self] _, _ in
                self.openApp()
            }
        }
        return TableViewSectionItem(cellItems: cellItems)
    }
    
    func openApp() {
        let url = URL(string: "hackathon://applications/\(0)")!
        extensionContext?.open(url, completionHandler: nil)
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
