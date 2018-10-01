//
//  FlowCollectionViewModel.swift
//  CloudInteractive
//
//  Created by Boshi Li on 2018/10/1.
//  Copyright © 2018 Boshi Li. All rights reserved.
//

import UIKit

protocol FlowCollectionViewPresentable: BasePresentable {
    func didGetPhotos(indices: [IndexPath])
}

class FlowCollectionViewModel: NSObject {
    
    // MARK: - Model
    private lazy var photos: [Photo] = [Photo]()
    private lazy var cellVMs: [PhotoCellViewModel] = [PhotoCellViewModel]()
    
    // MARK: - Properties
    private let apiService: PhotoAPIService
    private weak var presenter: FlowCollectionViewPresentable!
    
    // MARK: - ViewModel LifeCycle
    init(presenter: FlowCollectionViewPresentable, apiService: PhotoAPIService = PhotoAPIService()) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    deinit {
        URLSessionDataTask.cancelAllTaskList(of: type(of: self))
    }
    
    // MARK: - API Methods
    func getAllPhotos() {
        self.presenter.didUIStateChanged(.loading(.normalLoading))
        self.apiService.getPhotos([Photo].self) { [weak self] (state) in
            guard let weakSelf = self else { return }
            switch state {
            case .success(let photos):
                weakSelf.presenter.didUIStateChanged(.loaded(.uiChange))
                weakSelf.photos = photos
                weakSelf.insertCellVMs(photos)
            case .failure(let error):
                weakSelf.presenter.didUIStateChanged(.error(error, nil))
            }
        }.resumeAndAppendToTaskList(of: type(of: self))
    }
    
    // MARK: - Model Handlers
    func createCellVMs(_ photos: [Photo]) -> [PhotoCellViewModel] {
        return photos.map { PhotoCellViewModel(thumbnailURL: $0.thumbnailUrl) }
    }
    
    func insertCellVMs(_ photos: [Photo]) {
        let newCellVMs = self.createCellVMs(photos)
        var indices = [IndexPath]()
        let newCellVms = self.createCellVMs(photos)
        for i in self.cellVMs.count..<self.cellVMs.count + newCellVms.count {
            indices.append(IndexPath(item: i, section: 0))
        }
        guard  cellVMs.count < self.cellVMs.count + newCellVMs.count else {
            self.presenter.didGetPhotos(indices: [])
            return
        }
        self.photos.append(contentsOf: photos)
        self.cellVMs.append(contentsOf: newCellVms)
        self.presenter.didGetPhotos(indices: indices)
    }
}

// MARK: - CollectionView DataSource
extension FlowCollectionViewModel: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellVMs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.cellVMs[indexPath.row].cellInstance(cell: PhotoCell.self, collectionView: collectionView, atIndexPath: indexPath)
        cell.configure(withViewModel: self.cellVMs[indexPath.row])
        return cell
    }
    
}

// MARK: - CollectionView Flowlayout
extension FlowCollectionViewModel: PinterestLayoutDelegate {
    
    private var cellSize: CGSize {
        let width: CGFloat = DeviceSize.width.value / 4.0
        return CGSize(width: width, height: width - 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return self.cellSize.height
    }
}
