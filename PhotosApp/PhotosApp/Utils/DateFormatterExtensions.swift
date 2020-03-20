//
//  DateFormatterExtensions.swift
//  PhotosApp
//
//  Created by 임승혁 on 2020/03/19.
//  Copyright © 2020 임승혁. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter
    }()
}
