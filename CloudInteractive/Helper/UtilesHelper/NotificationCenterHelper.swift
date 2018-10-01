//
//  NotificationHelper.swift
//  Bump
//
//  Created by Boshi Li on 13/07/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import Foundation

extension Notification {
    init(name: String, object: Any?, message:String) {
        self.init(name: Notification.Name(rawValue: name), object: object, userInfo: ["info":message])
    }
}
