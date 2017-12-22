//
//  ExpandbleTableViewCell.swift
//  iMMiConnect
//
//  Created by Pandiyaraj on 19/12/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit

class ExpandbleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var checkBoxImageView : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.lineBreakMode = .byWordWrapping
       titleLabel.numberOfLines = 0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
