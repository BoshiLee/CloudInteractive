//
//  UIButton + Helper.swift
//  Gameplex
//
//  Created by Boshi Li on 2018/4/16.
//  Copyright © 2018 gameplex. All rights reserved.
//

import UIKit

extension UIButton {

    public convenience init(title: String, width: CGFloat, height: CGFloat, fontSize size: CGFloat, textColor: UIColor) {
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.titleLabel?.font = UIFont(name: "PingFang TC", size: CGFloat(size))
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
    }
}
