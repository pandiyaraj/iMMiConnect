//
//  PopUpTableViewCell.swift
//  iMMiConnect
//
//  Created by Murali on 12/17/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit

class PopUpTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
