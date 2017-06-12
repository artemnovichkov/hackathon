//
//  ExtendedViewController.swift
//  Hackathon
//
//  Created by Nikita Ermolenko on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import TableViewTools

protocol ExtendedViewControllerDelegate: class {
    func extendedViewController(_ viewController: ExtendedViewController, didPressApplicationAt index: Int)
}

class ExtendedViewController: UIViewController {

    weak var delegate: ExtendedViewControllerDelegate?
    var apps = [App]()
    
    @IBOutlet weak var tableView: UITableView!
    private lazy var tableViewManager: TableViewManager = {
        return TableViewManager(tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sectionItem = TableViewSectionItem()
        let cellItem = ExtendedTableViewCellItem()
        cellItem.itemDidSelectHandler = { [unowned self] _, indexPath in
            self.delegate?.extendedViewController(self, didPressApplicationAt: indexPath.row)
        }
        
        sectionItem.cellItems = [cellItem, cellItem, cellItem, cellItem]
        tableViewManager.sectionItems = [sectionItem]
    }
}
