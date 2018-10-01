//
//  UIImageHelper.swift
//  Bump
//
//  Created by JerryWang on 2018/4/26.
//  Copyright © 2018年 Boshi Li. All rights reserved.
//

import UIKit

// Make Thumbnail
extension UIImage {
    static func makeThumbnail(data: Data, maxPixelSize: Int) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        let options = [
            kCGImageSourceCreateThumbnailWithTransform : true,
            kCGImageSourceCreateThumbnailFromImageAlways : true,
            kCGImageSourceThumbnailMaxPixelSize : maxPixelSize
            ] as CFDictionary
        guard let cgImage =  CGImageSourceCreateThumbnailAtIndex(source, 0, options) else { return nil }
        let image = UIImage(cgImage: cgImage)
        return image
    }
}
