//
//  UIImage+Util.swift
//  SmoothScrolling
//
//  Created by Andrea Prearo on 2/15/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import UIKit

struct UIImageAPIManager: RequestManager {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func downloadImage(of url: URL, isCompression: Bool = false, completionHandler: @escaping ((UIImage?) -> Swift.Void)) -> URLSessionDataTaskProtocol {
        
        let request = HTTPService.generateRequest(urlString: url.absoluteString)
        let task = session.dataTask(with: request) { (data, response, url, error) in
            guard let data = self.handleDataResponse(with: (data, response, url, error)), let image = (isCompression) ? (UIImage.makeThumbnail(data: data, maxPixelSize: 512)) : (UIImage(data: data)) else {
                completionHandler(nil)
                return
            }
            CacheHelper.shared.saveImage(imageURL: url, image: image)
            completionHandler(image)
        }
        return task
        
    }
}



