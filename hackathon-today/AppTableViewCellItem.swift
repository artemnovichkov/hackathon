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
    let app: App
    
    init(app: App) {
        self.app = app
    }
    
    func height(in tableView: UITableView) -> CGFloat {
        return 50
    }
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: AppTableViewCell = tableView.dequeueReusableCell()
        cell.titleLabel.text = "\(app.name!), score: \(app.score)"
        return cell
    }
}
