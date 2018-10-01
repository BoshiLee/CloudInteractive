//
//  ArrayHelper.swift
//  Bump
//
//  Created by JerryWang on 2018/4/26.
//  Copyright © 2018年 Boshi Li. All rights reserved.
//

import Foundation

extension Array {
    func turnToString() -> String {
        return self.compactMap{"\($0)"}.joined(separator: ",")
    }
}
