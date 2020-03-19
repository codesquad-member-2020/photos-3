//
//  ImageData.swift
//  PhotosApp
//
//  Created by 임승혁 on 2020/03/18.
//  Copyright © 2020 임승혁. All rights reserved.
//

import Foundation

struct DoodleImageData: Codable {
    let title: String
    let image: URL
    let date: Date
}
