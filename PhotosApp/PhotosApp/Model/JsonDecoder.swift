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
    var doodleImgData: [DoodleImageData]?
    
    init() {
        doodleJsonDecode()
    }
    
    private func doodleJsonDecode() {
        guard let url = URL(string: doodleJsonURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.dateFormatter)
            
            if let data = data, let doodleImgDataList = try?
                decoder.decode([DoodleImageData].self, from: data) {
                self.doodleImgData = doodleImgDataList
            }
        }.resume()
    }
    
    // collection view indexpath item을 받아 다운로드해서 보여줌
    // collection view에선 비동기로 다운할수있게...
    private func fetchImage(index: Int) -> UIImage {
        guard let url = doodleImgData?[index].image else { return UIImage() }
        let data = try! Data(contentsOf: url)
        return UIImage(data: data)!
    }
}
