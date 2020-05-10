//
//  MovieReviewsModel.swift
//
//  Created by Jerry Purnama Maulid on 10/05/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct MovieReviewsModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case results = "results"
        case id = "id"
        case totalResults = "total_results"
        case page = "page"
    }
    
    var totalPages: Int?
    var results: [MovieReviewsResults]?
    var id: Int?
    var totalResults: Int?
    var page: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
        results = try container.decodeIfPresent([MovieReviewsResults].self, forKey: .results)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
        page = try container.decodeIfPresent(Int.self, forKey: .page)
    }
    
}

struct MovieReviewsResults: Codable {
    
    enum CodingKeys: String, CodingKey {
        case content = "content"
        case id = "id"
        case url = "url"
        case author = "author"
    }
    
    var content: String?
    var id: String?
    var url: String?
    var author: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        content = try container.decodeIfPresent(String.self, forKey: .content)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        author = try container.decodeIfPresent(String.self, forKey: .author)
    }
    
}
