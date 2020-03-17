//
//  ViewController.swift
//  PhotosApp
//
//  Created by Lin&Heidi on 2020/03/16.
//  Copyright © 2020 Lin&Heidi. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    let imageManager = PHCachingImageManager()
    var allPhotos: PHFetchResult<PHAsset>!
    var thumbnailSize: CGSize!
    
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        title = "Photos"
        
        allPhotos = PHAsset.fetchAssets(with: nil)
        setThumbnailSize()
    }
    
    func setThumbnailSize() {
        let scale = UIScreen.main.scale
        let cellSize = collectionViewFlowLayout.itemSize
        thumbnailSize = CGSize(width: cellSize.width * scale, height: cellSize.height * scale)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.item)
        let asset = self.allPhotos.object(at: indexPath.item)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { fatalError("collection view error") }
        
        cell.representedAssetIdentifier = asset.localIdentifier
        
        imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil) { image, _ in
            if cell.representedAssetIdentifier == asset.localIdentifier {
                cell.setPhoto(image!)
            }
        }
        
        return cell
    }
}
