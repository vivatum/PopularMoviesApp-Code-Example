//
//  PopularIdList.swift
//  PopularMovies
//
//  Created by Vivatum on 06/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation

struct PopularIdList: Decodable {
    
    let items: [Int]
    let page: Int?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalPages = "total_pages"
    }
    
    enum Nested: String, CodingKey {
        case id
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let collection = try values.decode([PopularItem].self, forKey: .results)
        items = collection.compactMap({ $0.id })
        page = try values.decode(Int?.self, forKey: .page)
        totalPages = try values.decode(Int?.self, forKey: .totalPages)
    }
}

fileprivate struct PopularItem: Decodable {
    
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int?.self, forKey: .id)
    }
}
