//
//  MovieListService.swift
//  PopularMovies
//
//  Created by Vivatum on 10/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift

protocol MovieListServiceProtocol: class {
    func getPlayingNowMovieList(complition: @escaping (Result<[PlayingNow], ActionError>) -> Void)
    func getPopularMovieList(for page: Int, complition: @escaping (Result<PopularDetailsList, ActionError>) -> Void)
}

final class MovieListService: MovieListServiceProtocol {
    
    private var playingNowFetcher: MovieFetchHelper?
    private var detailsFetcher: MovieDetailsFetcherProtocol?
    
    static let shared = MovieListService()
    private init(
        playingNowFetcher: MovieFetchHelper = MovieFetchHelper(),
        detailsFetcher: MovieDetailsFetcherProtocol = MovieDetailsFetcher()
    )
    {
        self.playingNowFetcher = playingNowFetcher
        self.detailsFetcher = detailsFetcher
    }
    
    func getPlayingNowMovieList(complition: @escaping (Result<[PlayingNow], ActionError>) -> Void) {
        DDLogInfo("Getting Playing Now List")
        guard let requestUrl = URLFactory.moviesNowPlayingRequestURL() else {
            let errorMessage = "Can't get request URL"
            DDLogError(errorMessage)
            complition(.failure(.custom(errorMessage)))
            return
        }
        self.playingNowFetcher?.fetchMoviePlayingNow(by: requestUrl, complition)
    }
    
    func getPopularMovieList(for page: Int, complition: @escaping (Result<PopularDetailsList, ActionError>) -> Void) {
         DDLogInfo("Getting Popular List")
        self.detailsFetcher?.getPopularMovieDetails(for: page, complition)
    }
}
