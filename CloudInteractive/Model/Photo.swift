//
//  Photo.swift
//  CloudInteractive
//
//  Created by Boshi Li on 2018/10/1.
//  Copyright © 2018 Boshi Li. All rights reserved.
//

import Foundation



struct Photo: Codable {
    let albumId: Int
    let photoId: Int
    let title: String
    let urlString: String
    let thumbnailUrlString: String
    
    enum CodingKeys: String, CodingKey {
        case albumId
        case photoId = "id"
        case title
        case urlString = "url"
        case thumbnailUrlString = "thumbnailUrl"
    }
}

extension Photo {
    var url: URL {
        return self.urlString.toImageURL("mountain")
    }
    var thumbnailUrl: URL {
        return self.thumbnailUrlString.toImageURL("mountain")
    }
}


