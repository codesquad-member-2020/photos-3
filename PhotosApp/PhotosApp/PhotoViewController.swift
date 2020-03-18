//
//  PhotoViewController.swift
//  PhotosApp
//
//  Created by Lin&Heidi on 2020/03/16.
//  Copyright © 2020 Lin&Heidi. All rights reserved.
//

import UIKit

class PhotoViewController: UICollectionViewController {
    
    private let photoDataSource = PhotoDataSource()
    private var photoObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = photoDataSource
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        
        setupBarButton()
        
        let center = NotificationCenter.default
        photoObserver = center.addObserver(forName: .photoDidChange) { [weak self] notification in
            DispatchQueue.main.async { self?.updateCollectionView(with: notification.userInfo) }
        }
    }
    
    deinit {
        guard let observer = photoObserver else { return }
        NotificationCenter.default.removeObserver(observer)
    }
    
    @objc private func showDoodles() { }
    
    private func setupBarButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showDoodles))
        navigationItem.leftBarButtonItem = button
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

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 3 - 1
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
