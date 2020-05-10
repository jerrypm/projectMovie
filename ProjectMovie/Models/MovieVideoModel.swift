//
//  MovieVideoModel.swift
//
//  Created by Jerry Purnama Maulid on 10/05/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct MovieVideoModel: Codable {

  enum CodingKeys: String, CodingKey {
    case results = "results"
    case id = "id"
  }

  var results: [MovieVideoResults]?
  var id: Int?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decodeIfPresent([MovieVideoResults].self, forKey: .results)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
  }

}
