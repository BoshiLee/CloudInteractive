//
//  TextFieldHelper.swift
//  Bump
//
//  Created by Boshi Li on 22/09/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setup(_ placeholder: String, of color: UIColor){
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.foregroundColor:color])
        self.text = ""
    }
}


