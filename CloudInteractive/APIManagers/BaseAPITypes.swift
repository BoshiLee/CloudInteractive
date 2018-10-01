//
//  BaseAPITypes.swift
//  CloudInteractive
//
//  Created by Boshi Li on 2018/10/1.
//  Copyright © 2018 Boshi Li. All rights reserved.
//

import Foundation

enum APIConsts: String {
    case baseAPIURL = "https://jsonplaceholder.typicode.com"
}

enum BaseAPIType: String {
    case v1
    case v2
    
    var url: String {
//        return APIConsts.baseAPIURL.rawValue + self.rawValue
        return APIConsts.baseAPIURL.rawValue // Replace this line if have version
    }
}
