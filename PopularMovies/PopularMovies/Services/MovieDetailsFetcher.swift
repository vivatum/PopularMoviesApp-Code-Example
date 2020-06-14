//
//  MovieDetailsHandler.swift
//  PopularMovies
//
//  Created by Vivatum on 06/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift

protocol MovieDetailsFetcherProtocol: class {
    func getPopularMovieDetails(for pageNumber: Int, _ completion: @escaping (Result<PopularDetailsList, ActionError>) -> Void)
}

final class MovieArrayWrapper {
    var fetchedMovies: [MovieDetails] = []
}

final class MovieDetailsFetcher: MovieDetailsFetcherProtocol {

    private let queue = OperationQueue()
    private var popularList = PopularDetailsList()
    
    func getPopularMovieDetails(for pageNumber: Int, _ completion: @escaping (Result<PopularDetailsList, ActionError>) -> Void) {
        DDLogInfo("Start getting Movie Details...")
        queue.cancelAllOperations()
        self.fetchPopularMovieList(for: pageNumber, completion)
    }
    
    private func fetchPopularMovieList(for pageNumber: Int, _ callBack: @escaping (Result<PopularDetailsList, ActionError>) -> Void) {
        DDLogInfo("Fetching Popular movie list ID")
        let fetchListId = FetchPopularIdListOperation(page: pageNumber)
        let adapter = BlockOperation() { [unowned fetchListId, unowned self] in
            DDLogInfo("Fetched id array count: \(String(describing: fetchListId.idCollection?.items.count))")
            self.popularList = self.updatePopularCollection(fetchListId.idCollection)
            self.fetchMoviesDetails(for: fetchListId.idCollection?.items, callBack)
        }
        adapter.addDependency(fetchListId)
        queue.addOperations([fetchListId, adapter], waitUntilFinished: true)
    }
    
    private func updatePopularCollection(_ parsedCollection: PopularIdList?) -> PopularDetailsList {
        var detailList = PopularDetailsList()
        detailList.page = parsedCollection?.page ?? 0
        detailList.totalPages = parsedCollection?.totalPages ?? 0
        return detailList
    }
    
    private func fetchMoviesDetails(for idArray: [Int]?, _ callBack: @escaping (Result<PopularDetailsList, ActionError>) -> Void) {
        DDLogInfo("Fetching Popular movie Details")
        
        guard let idCollection = idArray, !idCollection.isEmpty else {
            DDLogInfo("Popular movies id array is empty")
            callBack(.failure(.custom("Popular list ID is empty")))
            return
        }
        
        let movieCollectionWrapper = MovieArrayWrapper()
        
        let fetchingQueue = OperationQueue()
        fetchingQueue.maxConcurrentOperationCount = 1
        fetchingQueue.waitUntilAllOperationsAreFinished()
        queue.maxConcurrentOperationCount = idCollection.count
        
        let collectOperation = BlockOperation {
            var detailOperations = [FetchMovieDetailsOperation]()
            for (_, movieId) in idCollection.enumerated() {
                let detailsOperation = FetchMovieDetailsOperation(id: movieId, details: movieCollectionWrapper)
                detailOperations.append(detailsOperation)
            }
            
            self.queue.addOperations(detailOperations, waitUntilFinished: true)
            self.queue.addBarrierBlock {
                OperationQueue.main.addOperation {
                    DDLogInfo("Fetched Movie details: \(movieCollectionWrapper.fetchedMovies.count)")
                    self.popularList.results = movieCollectionWrapper.fetchedMovies
                    callBack(.success(self.popularList))
                }
            }
        }
        fetchingQueue.addOperation(collectOperation)
    }
    
}
