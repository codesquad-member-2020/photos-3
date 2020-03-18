//
//  PhotoCell.swift
//  PhotosApp
//
//  Created by 임승혁 on 2020/03/16.
//  Copyright © 2020 임승혁. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    
    func setPhoto(_ image: UIImage?) {
        guard let image = image else { return }
        photoImageView.image = image
    }
}
