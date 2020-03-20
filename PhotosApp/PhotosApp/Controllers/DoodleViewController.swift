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
    private let cellSize = CGSize(width: 110, height: 50)
    private var selectCellIndexPath: IndexPath?
    
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
        
        let longPressDetect = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressDetect.delegate = self
        longPressDetect.minimumPressDuration = 1.0
        self.collectionView.addGestureRecognizer(longPressDetect)
        
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
    
    private func enableSelectMenu(cell: UICollectionViewCell) {
        let selectMenuItem = UIMenuController.shared
        let selectItem = UIMenuItem(title: "save", action: #selector(saveImage))
        
        selectMenuItem.menuItems = [selectItem]
        selectMenuItem.showMenu(from: cell, rect: cell.contentView.frame)
    }
    
    @objc private func saveImage() {
        guard let indexPath = selectCellIndexPath else {
            return
        }
        let cell = self.collectionView.cellForItem(at: indexPath) as! DoodleCell
        UIImageWriteToSavedPhotosAlbum(cell.doodleImageView.image!, self, nil, nil)
    }
}

extension DoodleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension DoodleViewController: UIGestureRecognizerDelegate {
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.ended {
            return
        }
        else if sender.state == UIGestureRecognizer.State.began
        {
            let point = sender.location(in: self.collectionView)
            let indexPath = self.collectionView.indexPathForItem(at: point)

            if let index = indexPath {
                self.selectCellIndexPath = index
                let cell = self.collectionView.cellForItem(at: index)
                cell?.becomeFirstResponder()
                enableSelectMenu(cell: cell!)
            } else {
                print("Could not find index path")
            }
        }
    }
}
