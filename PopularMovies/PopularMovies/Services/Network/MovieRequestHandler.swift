//
//  MovieRequestHandler.swift
//  PopularMovies
//
//  Created by Vivatum on 05/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift

class MovieRequestHandler {
    
    func parseMovieIdList(_ responseData: Data, completion: @escaping (Result<PopularIdList, ActionError>) -> Void) {
        let decoder = JSONDecoder()
        DispatchQueue.global(qos: .background).async(execute: {
            do {
                let movieInfo = try decoder.decode(PopularIdList.self, from: responseData)
                completion(.success(movieInfo))
                DDLogInfo("Movie List parsed successfully")
            } catch {
                let errorMessage = "Can't parse Movie List: \(error)"
                DDLogError(errorMessage)
                completion(.failure(.parser(errorMessage)))
            }
        })
    }

    
    func parseMovieDetails(_ responseData: Data, completion: @escaping (Result<MovieDetails, ActionError>) -> Void) {
        let decoder = JSONDecoder()
        DispatchQueue.global(qos: .background).async(execute: {
            do {
                let movieInfo = try decoder.decode(MovieDetails.self, from: responseData)
                completion(.success(movieInfo))
                DDLogInfo("Movie Details parsed successfully")
            } catch {
                let errorMessage = "Can't parse Movie Details: \(error)"
                DDLogError(errorMessage)
                completion(.failure(.parser(errorMessage)))
            }
        })
    }
    
    func parsePlayingNow(_ responseData: Data, completion: @escaping (Result<[PlayingNow], ActionError>) -> Void) {
        let decoder = JSONDecoder()
        DispatchQueue.global(qos: .background).async(execute: {
            do {
                let movieInfo = try decoder.decode(PlayingNowList.self, from: responseData)
                completion(.success(movieInfo.results))
                DDLogInfo("PlayingNow Movie List parsed successfully")
            } catch {
                let errorMessage = "Can't parse PlayingNow Movie List: \(error)"
                DDLogError(errorMessage)
                completion(.failure(.parser(errorMessage)))
            }
        })
    }
}
