//
//  DoodleDataSource.swift
//  PhotosApp
//
//  Created by Chaewan Park on 2020/03/19.
//  Copyright © 2020 임승혁. All rights reserved.
//

import UIKit

class DoodleDataSource: NSObject {
    private let remoteSource = JsonDecoder()
}

extension DoodleDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return remoteSource.doodleCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoodleCell.reuseIdentifier, for: indexPath) as? DoodleCell else {
            return DoodleCell()
        }
        
        DispatchQueue.global(qos: .utility).async { [weak self] in
            let image = self?.remoteSource.fetchImage(index: indexPath.item)
            DispatchQueue.main.async { cell.setDoodle(to: image) }
        }
        return cell
    }
}
