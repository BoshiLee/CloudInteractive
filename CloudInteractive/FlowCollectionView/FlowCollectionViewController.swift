//
//  FlowCollectionViewController.swift
//  CloudInteractive
//
//  Created by Boshi Li on 2018/10/1.
//  Copyright © 2018 Boshi Li. All rights reserved.
//

import UIKit

class FlowCollectionViewController: BaseViewController {

    @IBOutlet weak var photoCollectionView: PinterestCollectionView! {
        didSet {
            self.photoCollectionView.dataSource = self.viewModel
            self.photoCollectionView.delegate = self.viewModel
        }
    }
    
    var layout: PinterestLayout?
    lazy var viewModel = FlowCollectionViewModel(presenter: self)
    override func viewDidLoad() {
        super.viewDidLoad()

        if let layout = photoCollectionView?.collectionViewLayout as? PinterestLayout {
            self.layout = layout
            layout.setCellPadding(2)
            layout.setNumberOfColumns(4)
            layout.delegate = self.viewModel
        }
        self.viewModel.getAllPhotos()
    }

}

extension FlowCollectionViewController: FlowCollectionViewPresentable {
    
    func didGetPhotos(indices: [IndexPath]) {
        self.photoCollectionView.performBatchUpdates({
            self.photoCollectionView.insertItems(at: indices)
        }, completion: nil)
    }
}
