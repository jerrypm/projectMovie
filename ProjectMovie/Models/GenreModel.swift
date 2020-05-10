//
//  GenreModel.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 10/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

import Foundation
import Mapper

struct GenreModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
    
    var genres: [Genres]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genres = try container.decodeIfPresent([Genres].self, forKey: .genres)
    }
    
}

struct Genres: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
    }
    
    var name: String?
    var id: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
    }
    
}
