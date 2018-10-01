//
//  BaseNavigationController.swift
//  Bump
//
//  Created by Boshi Li on 22/09/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    func setBumpStyleTitle(with font: FontStyle) {
        self.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.bumpRed,
            .font: UIFont(name: font.rawValue, size: 25)!
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        
        // Do any additional setup after loading the view.
    }
    
}
