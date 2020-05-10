//
//  MovieDetailModel.swift
//
//  Created by Jerry Purnama Maulid on 10/05/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieDetailModel {
    var genres: [MovieDetailGenres] = []
    var id: Int = 0
    var backdropPath: String?
    var title: String?
    var posterPath: String?
    var overview: String?
    var status: String?
    var releaseDate: String?
    
    required convenience init(json: JSON) {
        self.init()
        let genre = json["genres"].arrayValue
        for item in genre {
            let genre = MovieDetailGenres(json: item)
            self.genres.append(genre)
        }
        self.id = json["id"].intValue
        self.backdropPath = json["backdrop_path"].stringValue
        self.title = json["title"].stringValue
        self.posterPath = json["poster_path"].stringValue
        self.overview = json["overview"].stringValue
        self.status = json["status"].stringValue
        self.releaseDate = json["release_date"].stringValue
    }
}

class MovieDetailGenres {
    var id: Int?
    var name: String?
    
    required convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
    }
}
