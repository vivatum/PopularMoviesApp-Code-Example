//
//  RequestFactory.swift
//  PopularMovies
//
//  Created by Vivatum on 10/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation

final class RequestFactory {
    
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }
    
    static func request(method: Method, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
