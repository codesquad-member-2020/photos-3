//
//  File.swift
//  PhotosApp
//
//  Created by 임승혁 on 2020/03/18.
//  Copyright © 2020 임승혁. All rights reserved.
//

import Foundation
import UIKit

class JsonDecoder {
    private let doodleJsonURL = "https://public.codesquad.kr/jk/doodle.json"
    private var doodleImgData = [DoodleImageData]()
    
    var doodleCount: Int {
        return doodleImgData.count
    }
    
    init() {
        doodleJsonDecode()
    }
    
    private func doodleJsonDecode() {
        guard let url = URL(string: doodleJsonURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.dateFormatter)
            
            if let data = data,
                let doodleImgDataList = try? decoder.decode([DoodleImageData].self, from: data) {
                self.doodleImgData = doodleImgDataList
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .doodleDidChange, object: nil)
                }
            }
        }.resume()
    }
    
    func fetchImage(index: Int) -> UIImage {
        guard let data = try? Data(contentsOf: doodleImgData[index].image),
            let image = UIImage(data: data) else {
            return UIImage()
        }
        return image
    }
}
