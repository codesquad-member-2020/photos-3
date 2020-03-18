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
        
        photoObserver = NotificationCenter.default.addObserver(forName: .photoDidChange) { [weak self] _ in
            DispatchQueue.main.async { self?.collectionView.reloadData() }
        }
    }
    
    deinit {
        guard let observer = photoObserver else { return }
        NotificationCenter.default.removeObserver(observer)
    }
}
