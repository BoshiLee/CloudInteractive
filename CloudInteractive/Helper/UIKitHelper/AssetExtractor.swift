//
//  AssetExtractor.swift
//  Gameplex
//
//  Created by Boshi Li on 2018/4/30.
//  Copyright © 2018 gameplex. All rights reserved.
//

import UIKit

class AssetExtractor {
    
    static func createLocalUrl(forImageNamed name: String) -> URL? {
        
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        let path = url.path
        
        guard fileManager.fileExists(atPath: path) else {
            guard let pngData = UIImage(named: name)?.pngData() else { return nil }
            fileManager.createFile(atPath: path, contents: pngData, attributes: nil)
            return url
        }
        
        return url
    }
    
    static func createLocalUrl(formImage image: UIImage) -> URL? {
        
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        guard let name = image.accessibilityIdentifier else { return nil }
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        let path = url.path
        
        guard fileManager.fileExists(atPath: path) else {
            guard let pngData = UIImage(named: name)?.pngData() else { return nil }
            
            fileManager.createFile(atPath: path, contents: pngData, attributes: nil)
            return url
        }
        
        return url
    }

}
