//
//  HintView.swift
//  Gameplex
//
//  Created by Boshi Li on 2018/4/17.
//  Copyright © 2018 gameplex. All rights reserved.
//

import UIKit

class HintView: BaseXibView {

    @IBOutlet weak var cancelBtn: UIButton!{
        didSet {
            self.cancelBtn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        }
    }
    @IBOutlet weak var hintLabel: UILabel!
    
    func configure(_ hintText: String, textColor: UIColor, backgroundColor: UIColor) {
        self.hintLabel.text = hintText
        self.hintLabel.textColor = textColor
        self.backgroundColor = backgroundColor
    }

    @objc func dismiss() {
        self.isHidden = true
    }
}
