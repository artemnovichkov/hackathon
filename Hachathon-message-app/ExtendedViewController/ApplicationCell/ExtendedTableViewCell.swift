//
//  ExtendedTableViewCell.swift
//  Hackathon
//
//  Created by Nikita Ermolenko on 12/06/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

class ExtendedTableViewCell: UITableViewCell {

    @IBOutlet weak var applicationImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var crashFreeUsersLabel: UILabel!
    @IBOutlet weak var newUsersLabel: UILabel!
    @IBOutlet weak var activeUsersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
