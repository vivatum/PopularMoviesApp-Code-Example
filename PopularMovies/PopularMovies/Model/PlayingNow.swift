//
//  PlayingNow.swift
//  PopularMovies
//
//  Created by Vivatum on 05/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation

struct PlayingNow: Decodable {
    
    let id: Int?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int?.self, forKey: .id)
        posterPath = try values.decode(String?.self, forKey: .posterPath)
    }
}

struct PlayingNowList: Decodable {
    var results: [PlayingNow]
}
