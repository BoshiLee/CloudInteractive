//
//  PhotoAPIManager.swift
//  CloudInteractive
//
//  Created by Boshi Li on 2018/10/1.
//  Copyright © 2018 Boshi Li. All rights reserved.
//

import Foundation

enum PhotoAPIManager: APIEndPointProtocol {
    
    ///BaseURL Endpoint(parameter, header)
    case allPhotos
    
    ///Combinate all urls with their own endpoint.
    func baseURL(_ version: BaseAPIType) -> String {
        return version.url + "/photos"
    }
    
    var urlString : String {
        var combinatedURL: String
        switch self {
        case .allPhotos: combinatedURL = baseURL(.v1)
        }
        return combinatedURL
    }
    
    private func fetchParameters() -> RequestModel {
//        var header = [String: String]()
//        guard let token = UserDefaultsHelper.userAccessToken.read() as? String else { return (nil, nil) }
//        header[APIConsts.token.rawValue] = token
        return (nil, nil)
    }
    
    func provideValues() -> APIRequestValues {
        switch self {
        case .allPhotos:
            return APIRequestValues(url: self.urlString, requestModel: self.fetchParameters())
        }
    }
    
}
