//
//  PhotoDataSource.swift
//  PhotosApp
//
//  Created by 임승혁 on 2020/03/17.
//  Copyright © 2020 임승혁. All rights reserved.
//

import UIKit
import Photos

class PhotoDataSource: NSObject {

    enum ChangeType: Hashable {
        case isIncremental
        case inserted, removed
        case changed
    }
    
    private let imageManager = PHCachingImageManager()
    private var allPhotos: PHFetchResult<PHAsset>
    private var thumbnailSize: CGSize
    
    override init() {
        self.allPhotos = PHAsset.fetchAssets(with: nil)
        self.thumbnailSize = CGSize(width: 100, height: 100)
        super.init()
        PHPhotoLibrary.shared().register(self)
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
}

extension PhotoDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = self.allPhotos.object(at: indexPath.item)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as? PhotoCell else {
            return PhotoCell()
        }
        
        imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil) { image, _ in
            cell.setPhoto(image)
        }
        return cell
    }
}

extension PhotoDataSource: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: allPhotos) else { return }
        allPhotos = changes.fetchResultAfterChanges
        
        var changeInfo: Dictionary<ChangeType, Any> = [:]
        changeInfo[.isIncremental] = changes.hasIncrementalChanges
        
        if let removed = changes.removedIndexes {
            changeInfo[.removed] = removed.map { IndexPath(item: $0, section: 0) }
        }
        if let inserted = changes.insertedIndexes {
            changeInfo[.inserted] = inserted.map { IndexPath(item: $0, section: 0) }
        }
        if let changed = changes.changedIndexes {
            changeInfo[.changed] = changed.map { IndexPath(item: $0, section: 0) }
        }
        
        NotificationCenter.default.post(name: .photoDidChange, object: nil, userInfo: changeInfo)
    }
}
