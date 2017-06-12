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

    let app: App
    
    init(app: App) {
        self.app = app
    }
    
    var reuseType: ReuseType {
        return ReuseType.byStoryboardIdentifier("CompactedTableViewCell")
    }
    
    func height(in tableView: UITableView) -> CGFloat {
        return 70
    }
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompactedTableViewCell") as! CompactedTableViewCell
        cell.nameLabel.text = app.name
        
        if let image = app.image {
            cell.appImageView.image = image
        }
        else {
            let url = URL(string: self.app.icon!)!
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    self.app.image = image
                    DispatchQueue.main.async {
                        cell.appImageView.image = image
                    }
                }
            }
        }
        return cell
    }
}
