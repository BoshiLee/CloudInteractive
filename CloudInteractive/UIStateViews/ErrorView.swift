//
//  ErrorView.swift
//  testReach
//
//  Created by Boshi Li on 22/03/2018.
//  Copyright © 2018 Boshi Li. All rights reserved.
//

import UIKit

class ErrorView: BaseXibView {

    @IBOutlet weak var errorLable: UILabel! {
        didSet{
            self.errorLable.text = "error"
        }
    }
    
}
