//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by Chaewan Park on 2020/03/18.
//  Copyright © 2020 임승혁. All rights reserved.
//

import UIKit

class DoodleViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Doodles"
        collectionView.backgroundColor = .darkGray
        setupBarButton()
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    @objc private func dismissDoodles() {
        dismiss(animated: true)
    }
    
    private func setupBarButton() {
        let button = UIBarButtonItem(title: "Close",
                                     style: .plain,
                                     target: self,
                                     action: #selector(dismissDoodles))
        navigationItem.rightBarButtonItem = button
    }
}
