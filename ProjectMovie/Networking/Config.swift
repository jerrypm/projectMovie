//
//  Config.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 10/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

import Foundation

struct Config {
    // jeri API Key
    static let apiKey = "24952dbf6f2ae3933f104389595dc17b"
    static let lang = "en-US"
    
    struct URL {
        static let base = "http://api.themoviedb.org/3"
        static let basePoster = "http://image.tmdb.org/t/p/w780"
        static let baseYoutube = "http://www.youtube.com/embed/"
    }
}
