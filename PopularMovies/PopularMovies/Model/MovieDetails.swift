//
//  MovieDetails.swift
//  PopularMovies
//
//  Created by Vivatum on 05/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation

struct MovieDetails: Decodable {
    
    let id: Int?
    let title: String?
    let posterPath: String?
    let releaseDate: Date?
    let overview: String?
    let vote: Int
    let runtime: Int?
    let genres: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case overview
        case vote = "vote_average"
        case runtime
        case genres
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int?.self, forKey: .id)
        title = try values.decode(String?.self, forKey: .title)
        posterPath = try values.decode(String?.self, forKey: .posterPath)
        overview = try values.decode(String?.self, forKey: .overview)
        let voteDouble = try values.decode(Double?.self, forKey: .vote)
        vote = Int((voteDouble ?? 0) * 10)
        runtime = try values.decode(Int?.self, forKey: .runtime)
        
        let genresArray = try values.decode([Genre]?.self, forKey: .genres)
        genres = genresArray?.compactMap({ $0.name })
        
        do {
            let releaseDateString = try values.decode(String?.self, forKey: .releaseDate)
            if let date = releaseDateString {
                releaseDate = date.toDate(.reverseDate)
            } else {
                releaseDate = nil
            }
        } catch {
            releaseDate = nil
        }
    }
}

extension MovieDetails {
    
    func getSubtitleText() -> String? {
        let space = " - "
        guard
            let releaseDateString = self.releaseDate?.toString(format: .fullDate),
            let runtimeString = self.runtime?.toDurationString()
        else {
            return nil
        }
        return releaseDateString + space + runtimeString
    }
}


fileprivate struct Genre: Decodable {
    
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int?.self, forKey: .id)
        name = try values.decode(String?.self, forKey: .name)
    }
}
