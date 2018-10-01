//
//  ScreenShotHelper.swift
//  Bump
//
//  Created by JerryWang on 2018/3/12.
//  Copyright © 2018年 Boshi Li. All rights reserved.
//

import UIKit

struct ScreenHelper {
    private init() { }
    static func takeFullScreenshot() -> UIImage? {
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }
    
    static func takeScreenShot(of view: UIView) -> UIImage? {
        
        let imageSize = view.bounds.size as CGSize
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        for obj : AnyObject in UIApplication.shared.windows {
            if let window = obj as? UIWindow {
                if window.responds(to: #selector(getter: UIWindow.screen)) || window.screen == UIScreen.main {
                    context!.saveGState();
                    context!.translateBy(x: window.center.x, y: window.center
                        .y)
                    context!.concatenate(window.transform)
                    context!.translateBy(x: -window.bounds.size.width * window.layer.anchorPoint.x,
                                         y: -window.bounds.size.height * window.layer.anchorPoint.y)
                    view.layer.render(in: context!)
                    context!.restoreGState()
                }
            }
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        return image
    }
}
