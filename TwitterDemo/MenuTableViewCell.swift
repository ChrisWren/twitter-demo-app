//
//  MenuTableViewCell.swift
//  TwitterDemo
//
//  Created by Chris Wren on 6/4/16.
//  Copyright © 2016 Chris Wren. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

  @IBOutlet weak var menuLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
