//
//  ViewController.swift
//  PhotosApp
//
//  Created by Lin&Heidi on 2020/03/16.
//  Copyright © 2020 Lin&Heidi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    let collectionViewDataSource = PhotoDataSource()
    
    var photoObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        
        collectionView.dataSource = collectionViewDataSource
        
        let center = NotificationCenter.default
        photoObserver = center.addObserver(forName: .photoDidChange) { [weak self] notification in
            DispatchQueue.main.async { self?.updateCollectionView(with: notification.userInfo) }
        }
    }
    
    deinit {
        guard let observer = photoObserver else { return }
        NotificationCenter.default.removeObserver(observer)
    }
    
    private func updateCollectionView(with changes: Dictionary<AnyHashable, Any>?) {
        guard let collectionView = collectionView,
            let changes = changes as? Dictionary<PhotoDataSource.ChangeType, Any> else { return }
        
        if let isIncremental = changes[.isIncremental] as? Bool, isIncremental {
            collectionView.performBatchUpdates({
                if let removed = changes[.removed] as? [IndexPath], !removed.isEmpty {
                    collectionView.deleteItems(at: removed)
                }
                if let inserted = changes[.inserted] as? [IndexPath], !inserted.isEmpty {
                    collectionView.insertItems(at: inserted)
                }
            })
            if let changed = changes[.changed] as? [IndexPath], !changed.isEmpty {
                collectionView.reloadItems(at: changed)
            }
        } else {
            collectionView.reloadData()
        }
    }
}
