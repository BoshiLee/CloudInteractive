//
//  ViewConst.swift
//  Bump
//
//  Created by Boshi Li on 23/02/2018.
//  Copyright © 2018 Boshi Li. All rights reserved.
//

import UIKit

// MARK: - Width/Height
enum DeviceSize {
    case width
    case height
    
    var value: CGFloat {
        get {
            switch self {
            case .width:
                return UIScreen.main.bounds.size.width
            case .height:
                return UIScreen.main.bounds.size.height
            }
        }
    }
    
    static func getSize() -> CGSize {
        return UIScreen.main.bounds.size
    }
}
