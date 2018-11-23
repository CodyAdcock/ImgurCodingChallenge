//
//  ImgurImage.swift
//  SoFiCodingChallenge
//
//  Created by Cody on 11/23/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation
import UIKit

struct JsonDictionary: Decodable{
    let posts: [ImgurImage]
    private enum CodingKeys: String, CodingKey{
        case posts = "data"
    }
}

struct ImgurImage: Decodable{
    
    let link: String
    let title: String
    
    private enum CodingKeys: String, CodingKey {
        case link = "link"
        case title = "title"
    }
}
