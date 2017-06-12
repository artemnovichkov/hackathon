//
//  CompactedViewController.swift
//  Hackathon
//
//  Created by Nikita Ermolenko on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import TableViewTools

class CompactedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private lazy var tableViewManager: TableViewManager = {
        return TableViewManager(tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let sectionItem = TableViewSectionItem()
        let cellItem = CompactedTableViewCellItem()
        sectionItem.cellItems = [cellItem, cellItem, cellItem, cellItem]
        tableViewManager.sectionItems = [sectionItem]
    }
}
