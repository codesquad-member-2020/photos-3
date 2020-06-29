//
//  DoodleAPIClient.swift
//  PhotosApp
//
//  Created by 임승혁 on 2020/03/18.
//  Copyright © 2020 임승혁. All rights reserved.
//

import Foundation
import UIKit

class DoodleAPIClient {
    private let baseURL = "https://public.codesquad.kr/jk/doodle.json"
    private var doodles = [DoodleImage]()
    
    var doodleCount: Int {
        return doodles.count
    }
    
    init() {
        requestDoodleImages()
    }
    
    private func requestDoodleImages() {
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.dateFormatter)
            
            if let data = data, let doodleImages = try? decoder.decode([DoodleImage].self, from: data) {
                self.doodles = doodleImages
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .doodleDidChange, object: nil)
                }
            }
        }.resume()
    }
    
    func fetchImage(index: Int) -> UIImage {
        guard let data = try? Data(contentsOf: doodles[index].image),
            let image = UIImage(data: data) else {
            return UIImage()
        }
        return image
    }
}
