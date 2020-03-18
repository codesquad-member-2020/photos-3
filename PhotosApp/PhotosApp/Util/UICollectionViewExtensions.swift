//
//  UICollectionViewExtensions.swift
//  PhotosApp
//
//  Created by Chaewan Park on 2020/03/17.
//  Copyright © 2020 임승혁. All rights reserved.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return "PhotoCell"
    }
}

extension UICollectionViewCell: ReusableView { }
