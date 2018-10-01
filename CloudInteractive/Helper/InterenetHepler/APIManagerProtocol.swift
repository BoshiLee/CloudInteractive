//
//  BaseAPIManager.swift
//  BumpTwo
//
//  Created by JerryWang on 2018/1/28.
//  Copyright © 2018年 Jerrywang. All rights reserved.
//

import UIKit

// MARK: - URLs implementation protocol
///All URL layer need to implement this protocol
typealias RequestModel = (parameters: [String : Any]?, header: [String: String]?)

protocol APIEndPointProtocol {
    func provideValues()-> APIRequestValues
}

struct APIRequestValues {
    let url: String
    let encodeType: URLRequest.EncodeType
    let requestModel: RequestModel
    
    init (url: String, encodeType: URLRequest.EncodeType = .inURL(.GET), requestModel: RequestModel) {
        self.url = url
        self.encodeType = encodeType
        self.requestModel = requestModel
    }
}
