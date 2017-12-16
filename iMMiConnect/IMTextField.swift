//
//  IMTextField.swift
//  iMMiConnect
//
//  Created by Pandiyaraj on 13/12/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit

class IMTextField: UITextField , UITextFieldDelegate {
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
        createBorder()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        createBorder()
    }
    
    func createBorder() {
        self.setPlaceHolderTextColor(UIColor.init(hex: 0xC7C7CD))
        self.addBorder(edges: .bottom, colour: UIColor.init(hex: 0xbababa), thickness: 1.0)
    }

}
