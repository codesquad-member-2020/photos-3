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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var fetchResult: PHFetchResult<PHAsset>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        title = "Photos"
        
        PHPhotoLibrary.shared().register(self)
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
}

extension ViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: fetchResult) else { return }
        fetchResult = changes.fetchResultAfterChanges
        DispatchQueue.main.sync { collectionView.reloadData() }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red: CGFloat.randomForColor(),
                       green: CGFloat.randomForColor(),
                       blue: CGFloat.randomForColor(),
                       alpha: 1)
    }
}

extension CGFloat {
    static func randomForColor() -> CGFloat {
        return CGFloat.random(in: 0...1)
    }
}
