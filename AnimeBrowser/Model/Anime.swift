//
//  Anime.swift
//  AnimeBrowser
//
//  Created by Leonardo Diaz on 4/29/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import Foundation

struct AnimeTopLevelObject: Decodable {
    let top: [Anime]
}

struct Anime: Decodable {
    let title: String
    let type: String
    let imageURL: String
    let startDate: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case startDate = "start_date"
        case title
        case type
    }
}
