//
//  MainViewController.swift
//  Hackathon
//
//  Created by Artem Novichkov on 10/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import TableViewTools

class MainViewController: UIViewController {
    
    var tableViewManager: TableViewManager!
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewManager = TableViewManager(tableView: tableView)
        tableViewManager.sectionItems = [testAppSectionItem()]
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func testAppSectionItem() -> TableViewSectionItem {
        let appTitles = ["Calico", "RandomChat", "Phyzseek", "HypeType", "Trackd"]
        let cellItems = appTitles.map { title -> TableViewCellItemProtocol in
            let cellItem = AppTableViewCellItem(title: title)
            cellItem.itemDidSelectHandler = { [unowned self] _, _ in
                self.show(DetailViewController(), sender: nil)
            }
            return cellItem
        }
        return TableViewSectionItem(cellItems: cellItems)
    }
}
