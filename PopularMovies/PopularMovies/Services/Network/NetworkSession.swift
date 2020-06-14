//
//  NetworkSession.swift
//  PopularMovies
//
//  Created by Vivatum on 10/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation

protocol NetworkSession {
    func loadData(request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: request) { (data, _, error) in completionHandler(data, error) }
        task.resume()
    }
}
