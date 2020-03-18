//
//  PhotoCell.swift
//  PhotosApp
//
//  Created by 임승혁 on 2020/03/16.
//  Copyright © 2020 임승혁. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    private var photoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    func setPhoto(_ image: UIImage?) {
        guard let image = image else { return }
        photoImageView.image = image
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(photoImageView)
        photoImageView.fillSuperView()
    }
}
