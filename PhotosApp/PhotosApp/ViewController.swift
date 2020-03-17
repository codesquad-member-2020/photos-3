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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = collectionViewDataSource
        collectionViewDataSource.delegate = self
        title = "Photos"
    }
}

extension ViewController: PhotoDataSourceDelegate {
    func photoLibraryDidUpdate() {
        DispatchQueue.main.sync { collectionView.reloadData() }
    }
}
