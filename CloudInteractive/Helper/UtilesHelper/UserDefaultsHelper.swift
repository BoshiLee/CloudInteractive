//
//  UserDefaultKey.swift
//  Bump
//
//  Created by Boshi Li on 28/06/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import Foundation

enum UserDefaultsHelper: String {
    
    case useCounts
    case deviceToken = "Device Token"
    case userAccessToken
    case userID
    case uuid
    case appVersion
    case iOSVersion
    case userLocation
    case groupID
    case chatroomType
    case preferRegion
    case playingName
    case latestNotice
    case notificationSwitchStatus
    
    func read() -> Any? {
        let result = UserDefaults.standard.object(forKey: rawValue)
        return result
    }
    func set(_ content: Any) {
        UserDefaults.standard.set(content, forKey: rawValue)
        UserDefaults.standard.synchronize()
    }
}


