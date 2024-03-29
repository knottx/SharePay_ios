//
//  Person.swift
//  SharePay
//
//  Created by Visarut Tippun on 2/5/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import UIKit

struct Person {
    var id:Int?
    var name:String?
    var image:UIImage?
    
    init(name:String, image:UIImage?) {
        self.id = Int(Date().timeIntervalSince1970)
        self.name = name
        self.image = image
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
    }
}

extension Person: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
        if let base64ImageData = try? container.decode(String.self, forKey: .image),
           let imageData = Data(base64Encoded: base64ImageData) {
            self.image = UIImage(data: imageData)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var value = encoder.container(keyedBy: CodingKeys.self)
        try? value.encode(self.id, forKey: .id)
        try? value.encode(self.name, forKey: .name)
        if let imageData:Data = self.image?.jpegData(compressionQuality: 0.25) {
            let base64ImageData = imageData.base64EncodedString()
            try? value.encode(base64ImageData, forKey: .image)
        }
    }
}
