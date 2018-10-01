//
//  NavigationBarButtonItemHelper.swift
//  Gameplex
//
//  Created by Boshi Li on 2018/4/16.
//  Copyright © 2018 gameplex. All rights reserved.
//

import UIKit

protocol NavigationItemShowable: AnyObject { }

extension NavigationItemShowable where Self: UIViewController {
    
    func addNavigationItem(leftBarButtonItems: [UIBarButtonItem] = [UIBarButtonItem](), rightBarButtonItems: [UIBarButtonItem] = [UIBarButtonItem]()) {
        guard (self.navigationController?.navigationBar) != nil else { return }
        self.navigationItem.leftBarButtonItems = leftBarButtonItems
        self.navigationItem.rightBarButtonItems = rightBarButtonItems
    }
    
    func createBarButtonItem(_ title: String, textColor: UIColor, action: Selector) -> UIBarButtonItem {
        let cancelBtn = UIButton(title: title, width: 44, height: 44, fontSize: 18, textColor: textColor)
        cancelBtn.addTarget(self, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: cancelBtn)
    }
}
