//
//  CompactedTableViewCell.swift
//  Hackathon
//
//  Created by Nikita Ermolenko on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

class CompactedTableViewCell: UITableViewCell {

    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
