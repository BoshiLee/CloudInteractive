//
//  BaseViewPresentAble.swift
//  Bump
//
//  Created by Boshi Li on 20/02/2018.
//  Copyright © 2018 Boshi Li. All rights reserved.
//

import UIKit

//所有的Presentable 要繼承自BasePresentable
protocol BasePresentable: AnyObject {
    func didUIStateChanged(_ state: UIState)
}
