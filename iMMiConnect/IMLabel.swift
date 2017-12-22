//
//  IMLabel.swift
//  iMMiConnect
//
//  Created by Pandiyaraj on 20/12/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit

class IMLabel: UILabel {

    override func awakeFromNib() {
        
        let range = NSRange(location:(self.text?.count)! - 1,length:1) // specific location. This means "range" handle 1 character at location 2
        let attributedString = NSMutableAttributedString(string: self.text!)        // here you change the character to red color
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: range)
        
        self.attributedText = attributedString
    }
}
