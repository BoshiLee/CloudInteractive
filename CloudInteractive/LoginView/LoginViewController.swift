//
//  LoginViewController.swift
//  CloudInteractive
//
//  Created by Boshi Li on 2018/10/1.
//  Copyright © 2018 Boshi Li. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController, ViewControllerTransitionable {
    @IBAction func requestAPI(_ sender: Any) {
        self.pushUnderNavigationController(FlowCollectionViewController.self, of: .main)
    }
    
}
