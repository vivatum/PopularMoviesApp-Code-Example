//
//  MovieFetchHelper.swift
//  PopularMovies
//
//  Created by Vivatum on 06/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift

protocol MovieFetchProtocol: class {
    func fetchMovieIdList(by url: URL, _ completion: @escaping (Result<PopularIdList, ActionError>) -> Void)
    func fetchMovieDetails(by url: URL, _ completion: @escaping (Result<MovieDetails, ActionError>) -> Void)
    func fetchMoviePlayingNow(by url: URL, _ completion: @escaping (Result<[PlayingNow], ActionError>) -> Void)
}

final class MovieFetchHelper: MovieRequestHandler, MovieFetchProtocol {
    
    func fetchMovieIdList(by url: URL, _ completion: @escaping (Result<PopularIdList, ActionError>) -> Void) {
        
        guard let reachability = Reachability(), reachability.isReachable else {
            let errorMessage = "Can't load Data: Network unreachable!"
            DDLogError(errorMessage)
            return completion(.failure(.reachability(errorMessage)))
        }
        
        RequestService().loadData(url: url) { result in
            switch result {
            case .success(let data):
                self.parseMovieIdList(data, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieDetails(by url: URL, _ completion: @escaping (Result<MovieDetails, ActionError>) -> Void) {
        
        guard let reachability = Reachability(), reachability.isReachable else {
            let errorMessage = "Can't load Data: Network unreachable!"
            DDLogError(errorMessage)
            return completion(.failure(.reachability(errorMessage)))
        }
        
        RequestService().loadData(url: url) { result in
            switch result {
            case .success(let data):
                self.parseMovieDetails(data, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMoviePlayingNow(by url: URL, _ completion: @escaping (Result<[PlayingNow], ActionError>) -> Void) {
        
        guard let reachability = Reachability(), reachability.isReachable else {
            let errorMessage = "Can't load Data: Network unreachable!"
            DDLogError(errorMessage)
            return completion(.failure(.reachability(errorMessage)))
        }

        RequestService().loadData(url: url) { result in
            switch result {
            case .success(let data):
                self.parsePlayingNow(data, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
