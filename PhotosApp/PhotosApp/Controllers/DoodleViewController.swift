//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by Chaewan Park on 2020/03/18.
//  Copyright © 2020 임승혁. All rights reserved.
//

import UIKit

class DoodleViewController: UICollectionViewController {
    
    private let doodleDataSource = DoodleDataSource()
    private var doodleObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Doodles"
        collectionView.backgroundColor = .darkGray
        
        collectionView.dataSource = doodleDataSource
        collectionView.register(DoodleCell.self, forCellWithReuseIdentifier: DoodleCell.reuseIdentifier)
        
        let center = NotificationCenter.default
        doodleObserver = center.addObserver(forName: .doodleDidChange) { [weak self] notification in
            DispatchQueue.main.async { self?.collectionView.reloadData() }
        }
        
        setupBarButton()
    }
    
    deinit {
        guard let observer = doodleObserver else { return }
        NotificationCenter.default.removeObserver(observer)
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

extension DoodleViewController: UICollectionViewDelegateFlowLayout {
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
