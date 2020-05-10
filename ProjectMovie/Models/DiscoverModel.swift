//
//  DiscoverBase.swift
//
//  Created by Jerry Purnama Maulid on 10/05/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DiscoverBase: Codable {

  enum CodingKeys: String, CodingKey {
    case results = "results"
    case totalResults = "total_results"
    case totalPages = "total_pages"
    case page = "page"
  }

  var results: [DiscoverResults]?
  var totalResults: Int?
  var totalPages: Int?
  var page: Int?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decodeIfPresent([DiscoverResults].self, forKey: .results)
    totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
    totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
    page = try container.decodeIfPresent(Int.self, forKey: .page)
  }

}
