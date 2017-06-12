//
//  AppTableViewCellItem.swift
//  hackathon-today
//
//  Created by Artem Novichkov on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import TableViewTools

class AppTableViewCellItem: TableViewCellItemProtocol {
    
    let reuseType = ReuseType(cellClass: AppTableViewCell.self)
    
    func height(in tableView: UITableView) -> CGFloat {
        return tableView.bounds.height / 2
    }
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: AppTableViewCell = tableView.dequeueReusableCell()
        cell.titleLabel.text = "\(indexPath.row)"
        return cell
    }
}
