//
//  RequestService.swift
//  PopularMovies
//
//  Created by Vivatum on 05/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift


final class RequestService {
    
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func loadData(url: URL, completion: @escaping (Result<Data, ActionError>) -> Void) {
        let request = RequestFactory.request(method: .GET, url: url)
        session.loadData(request: request) { data, error in
            if let err = error {
                completion(.failure(.network("An error occured during request :" + err.localizedDescription)))
                DDLogError("Task request error: \(err.localizedDescription)")
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
    }
}
