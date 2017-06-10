//
//  AppTableViewCellItem.swift
//  Hackathon
//
//  Created by Artem Novichkov on 10/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import TableViewTools

class AppTableViewCellItem: TableViewCellItemProtocol {
    
    let title: String
    
    let reuseType = ReuseType(cellClass: AppTableViewCell.self)
    
    init(title: String) {
        self.title = title
    }
    
    func height(in tableView: UITableView) -> CGFloat {
        return 50
    }
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: AppTableViewCell = tableView.dequeueReusableCell()
        cell.titleLebel.text = title
        return cell
    }
}
