//
//  CALayerHelper.swift
//  Bump
//
//  Created by JerryWang on 2017/9/20.
//  Copyright © 2017年 Boshi Li. All rights reserved.
//

import UIKit

enum GradientHelper {
    case topToBottom
    case bottomToTop
    case leftToRight
    case rightToLeft
    case topLeftToBottomRight
    case topRightToBottomLeft
    case bottomLeftToTopRight
    case bottomRightToTopLeft
    
    func createGradientLayer(ofDirection: GradientHelper, frame: CGRect, colorSets: [CGColor], locations: [NSNumber]) -> CAGradientLayer {
        
        let point = fetchGradientDirection(ofGradientDirections: ofDirection)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = colorSets
        gradientLayer.locations = locations //0.0~1.0
        gradientLayer.startPoint = point.0
        gradientLayer.endPoint = point.1
        
        return gradientLayer
    }
    
    private func fetchGradientDirection(ofGradientDirections: GradientHelper) -> (CGPoint, CGPoint){
        var startPoint = CGPoint.zero
        var endPoint = CGPoint.zero
        
        switch ofGradientDirections {
        case .leftToRight:
            startPoint = CGPoint(x: 0.0, y: 0.5)
            endPoint = CGPoint(x: 1.0, y: 0.5)
            
        case .rightToLeft:
            startPoint = CGPoint(x: 1.0, y: 0.5)
            endPoint = CGPoint(x: 0.0, y: 0.5)
            
        case .topToBottom:
            startPoint = CGPoint(x: 0.5, y: 0.0)
            endPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .bottomToTop:
            startPoint = CGPoint(x: 0.5, y: 1.0)
            endPoint = CGPoint(x: 0.5, y: 0.0)
            
        case .topLeftToBottomRight:
            startPoint = CGPoint(x: 0.0, y: 0.0)
            endPoint = CGPoint(x: 1.0, y: 1.0)
            
        case .topRightToBottomLeft:
            startPoint = CGPoint(x: 1.0, y: 0.0)
            endPoint = CGPoint(x: 0.0, y: 1.0)
            
        case .bottomLeftToTopRight:
            startPoint = CGPoint(x: 0.0, y: 1.0)
            endPoint = CGPoint(x: 1.0, y: 0.0)
            
        case .bottomRightToTopLeft:
            startPoint = CGPoint(x: 1.0, y: 1.0)
            endPoint = CGPoint(x: 0.0, y: 0.0)
        }
        return (startPoint, endPoint)
    }
}
