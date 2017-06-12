//
//  ExtendedTableViewCellItem.swift
//  Hackathon
//
//  Created by Nikita Ermolenko on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import TableViewTools

class ExtendedTableViewCellItem: TableViewCellItemProtocol {

    var reuseType: ReuseType {
        return ReuseType.byStoryboardIdentifier("ExtendedTableViewCell")
    }
    
    func height(in tableView: UITableView) -> CGFloat {
        return 300
    }
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExtendedTableViewCell") as! ExtendedTableViewCell
        return cell
    }
}
