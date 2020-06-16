//
//  URLFactory.swift
//  PopularMovies
//
//  Created by Vivatum on 05/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation

struct URLFactory {
    
    static let apiKey = "?api_key=40bdbf8af85f8fea90999afee97574c4"
    static let base = "https://api.themoviedb.org/3/movie/"
    static let playingNow = "now_playing"
    static let popular = "popular"
    static let responseLanguage = "&language=en-US"
    static let requestPage = "&page="
    static let moviePoster = "https://image.tmdb.org/t/p/w500/"
    
    
    static func moviesNowPlayingRequestURL() -> URL? {
        let urlString = base + playingNow + apiKey + responseLanguage
        return URL(string: urlString)
    }
    
    static func moviesPopularRequestURL(_ page: Int) -> URL? {
        let urlString = base + popular + apiKey + responseLanguage + requestPage + String(describing: page)
        return URL(string: urlString)
    }
    
    static func movieDetailsRequestURL(_ id: Int) -> URL? {
        let urlString = base + String(describing: id) + apiKey + responseLanguage
        return URL(string: urlString)
    }
    
    static func posterRequestURL(_ imagePath: String) -> URL? {
        let urlString = moviePoster + imagePath
        return URL(string: urlString)
    }
    
}
