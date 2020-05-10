//
//  MovieDetailModel.swift
//
//  Created by Jerry Purnama Maulid on 10/05/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

struct MovieDetailModel: Codable {

  enum CodingKeys: String, CodingKey {
    case genres = "genres"
    case id = "id"
    case backdropPath = "backdrop_path"
    case title = "title"
    case posterPath = "poster_path"
    case overview = "overview"
    case status = "status"
    case releaseDate = "release_date"
  }

  var genres: [MovieDetailGenres]?
  var id: Int?
  var backdropPath: String?
  var title: String?
  var posterPath: String?
  var overview: String?
  var status: String?
  var releaseDate: String?
    
    init(json: JSON) {
        self.init()
        
        
    }

}

struct MovieDetailGenres: Codable {

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
  }

  var id: Int?
  var name: String?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }

}
