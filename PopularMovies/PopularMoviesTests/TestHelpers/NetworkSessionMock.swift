//
//  NetworkSessionMock.swift
//  PopularMoviesTests
//
//  Created by Vivatum on 10/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation

public class NetworkSessionMock: NetworkSession {
    
    var data: Data?
    var error: Error?

    func loadData(request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
}
