//
//  BaseTabBarController.swift
//  Bump
//
//  Created by Boshi Li on 22/09/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.layer.borderWidth = 0
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.clipsToBounds = true

    }

}
