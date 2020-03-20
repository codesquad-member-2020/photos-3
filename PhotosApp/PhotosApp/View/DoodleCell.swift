//
//  DoodleCell.swift
//  PhotosApp
//
//  Created by Chaewan Park on 2020/03/19.
//  Copyright © 2020 임승혁. All rights reserved.
//

import UIKit

class DoodleCell: UICollectionViewCell {
    
    private(set) var doodleImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
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
    
    func setDoodle(to image: UIImage?) {
        guard let image = image else { return }
        doodleImageView.image = image
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(doodleImageView)
        doodleImageView.fillSuperView()
    }
}
