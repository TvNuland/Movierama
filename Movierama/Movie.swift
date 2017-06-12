//
//  Movie.swift
//  Movierama
//
//  Created by Ton on 2017-06-06.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import UIKit

class Movie {
    
    let title: String
    let poster: String
    var posterImage: UIImage? = nil
    let imdbID: String
    let year: String
    
    init(title: String, imdbID: String, poster: String, year: String) {
        self.title = title
        self.imdbID = imdbID
        self.poster = poster
        self.year = year
    }
}
