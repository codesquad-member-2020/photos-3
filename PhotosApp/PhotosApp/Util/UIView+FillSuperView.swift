//
//  UIView+FillSuperView.swift
//  PhotosApp
//
//  Created by Chaewan Park on 2020/03/18.
//  Copyright © 2020 임승혁. All rights reserved.
//

import UIKit

extension UIView {
    func fillSuperView() {
        guard let superview = superview else { return }
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
}
