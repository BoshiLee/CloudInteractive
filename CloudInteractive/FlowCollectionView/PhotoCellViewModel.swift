//
//  PhotoCellViewModel.swift
//  CloudInteractive
//
//  Created by Boshi Li on 2018/10/1.
//  Copyright © 2018 Boshi Li. All rights reserved.
//

import Foundation

class PhotoCellViewModel: CollectionCellViewModelProtocol {
    let thumbnailURL: URL
    
    init (thumbnailURL: URL) {
        self.thumbnailURL = thumbnailURL
    }
    
}
