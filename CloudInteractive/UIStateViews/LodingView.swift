//
//  LodingView.swift
//  testReach
//
//  Created by Boshi Li on 22/03/2018.
//  Copyright © 2018 Boshi Li. All rights reserved.
//

import UIKit

class LoadingView: BaseXibView {
    
    @IBOutlet weak var spiningIndicator: UIActivityIndicatorView! {
        didSet {
            spiningIndicator.startAnimating()
        }
    }
}
