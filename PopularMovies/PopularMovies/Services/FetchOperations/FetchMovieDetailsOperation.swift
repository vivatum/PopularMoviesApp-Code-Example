//
//  FetchMovieDetailsOperation.swift
//  PopularMovies
//
//  Created by Vivatum on 06/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift

final class FetchMovieDetailsOperation: AsyncOperation {
    
    private let dataWrapper: MovieArrayWrapper
    private var movieId: Int
    
    init(id: Int, details: MovieArrayWrapper) {
        self.movieId = id
        self.dataWrapper = details
    }
    
    override func main() {
        DDLogInfo("Start fetching details for Movie id: \(self.movieId)")
        self.fetchDetails()
    }
    
    private func fetchDetails() {
        
        guard let requestUrl = URLFactory.movieDetailsRequestURL(self.movieId) else {
            let errorMessage = "Can't get request URL"
            DDLogError(errorMessage)
            self.finish()
            return
        }
        
        let fetchService = MovieFetchHelper()
        fetchService.fetchMovieDetails(by: requestUrl) { result in
            switch result {
            case .success(let movie):
                OperationQueue.main.addOperation {
                    self.dataWrapper.fetchedMovies.append(movie)
                }
                DDLogInfo("Details fetched for Movie id: \(self.movieId)")
                self.finish()
            case .failure(let error):
                DDLogError("Can't get details for MovieId: \(self.movieId). \(error.localizedDescription)")
                self.finish()
            }
        }
    }
    
}
