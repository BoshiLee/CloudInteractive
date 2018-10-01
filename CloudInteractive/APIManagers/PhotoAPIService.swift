//
//  PhotoAPIService.swift
//  CloudInteractive
//
//  Created by Boshi Li on 2018/10/1.
//  Copyright © 2018 Boshi Li. All rights reserved.
//

import Foundation

struct PhotoAPIService: RequestManager {
    
    internal let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) { // 測 (data, urlResponse, url, error)
        self.session = session
    }
    
    func getPhotos<T>(_ model: T.Type, completionHandler: @escaping ResultCompletionHandler<T>) -> URLSessionDataTaskProtocol {
        let apiInformation = PhotoAPIManager.allPhotos
        let task = generateTask(with: apiInformation, model: model, completionHandler)
        return task
    }
}
