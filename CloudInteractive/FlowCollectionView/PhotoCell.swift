//
//  PhotoCell.swift
//  CloudInteractive
//
//  Created by Boshi Li on 2018/10/1.
//  Copyright © 2018 Boshi Li. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: WebImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = #imageLiteral(resourceName: "mountain")
    }

    func configure(withViewModel viewModel: PhotoCellViewModel) {
        self.imageView.load(url: viewModel.thumbnailURL)
    }

}
