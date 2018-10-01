//
//  CacheHelper.swift
//  Bump
//
//  Created by Boshi Li on 2017-06-03.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

struct CacheHelper {
    private init() {}
    static let shared = CacheHelper()
    private let cache = NSCache<NSString, UIImage>()
    
    func saveImage(imageURL: URL, image: UIImage) {
        let indexString = imageURL.absoluteString as NSString
        self.cache.setObject(image, forKey: indexString)
    }
    
    func loadImage(imageURL: URL) -> UIImage? {
        let indexString = imageURL.absoluteString as NSString
        guard let image = self.cache.object(forKey: indexString) else {
            return nil
        }
        return image
    }
}
