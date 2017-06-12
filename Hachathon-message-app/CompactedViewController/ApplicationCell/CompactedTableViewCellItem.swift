//
//  CompactedTableViewCellItem.swift
//  Hackathon
//
//  Created by Nikita Ermolenko on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import TableViewTools

class CompactedTableViewCellItem: TableViewCellItemProtocol {

    var reuseType: ReuseType {
        return ReuseType.byStoryboardIdentifier("CompactedTableViewCell")
    }
    
    func height(in tableView: UITableView) -> CGFloat {
        return 70
    }
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompactedTableViewCell") as! CompactedTableViewCell
        return cell
    }
}
