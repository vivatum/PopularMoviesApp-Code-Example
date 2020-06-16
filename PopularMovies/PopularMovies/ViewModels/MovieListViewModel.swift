//
//  MovieListViewModel.swift
//  PopularMovies
//
//  Created by Vivatum on 07/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift

protocol MovieViewModelDelegate: class {
    func posterListUpdated(_ posterList: [PlayingNow])
    func movieListUpdated(with newIndexPathsToReload: [IndexPath]?, _ noDataMessage: NoDataMessage)
    func showMovieDetails(_ movie: MovieDetails?)
    func errorHandling(_ error: ActionError?, _ noDataMessage: NoDataMessage)
}

protocol MovieListViewModelProtocol: class {
    func fetchPlayingNowMovies()
    func fetchPopularMovies()
    var popularList: PopularDetailsList { get set }
    var selectedIndexPath: IndexPath? { get set }
}

final class MovieListViewModel: NSObject, MovieListViewModelProtocol {
    
    private weak var dataSource: MovieListDataSource?
    private var listService: MovieListServiceProtocol?
    weak var delegate: MovieViewModelDelegate?
    
    var popularList = PopularDetailsList()
    
    var selectedIndexPath: IndexPath? {
        didSet {
            self.handleSelectedIndexPath(selectedIndexPath)
        }
    }
    
    init(dataSource: MovieListDataSource,
         listService: MovieListServiceProtocol = MovieListService.shared)
    {
        self.dataSource = dataSource
        self.listService = listService
    }
    
    // MARK: - Fetch movie list
    
    public func fetchPlayingNowMovies() {
        DDLogInfo("Start fetching PlayingNow Movies")
        let playingNowQueue = OperationQueue()
        playingNowQueue.addOperation {
            self.listService?.getPlayingNowMovieList(complition: self.playingNowResultHandler)
        }
    }
    
    private func playingNowResultHandler(result: Result<[PlayingNow], ActionError>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let posterList):
                DDLogInfo("PlayingNow Movies count: \(posterList.count)")
                self.dataSource?.playingNowCollection = posterList
                self.delegate?.posterListUpdated(posterList)
                DDLogInfo("PlayingNow Movie List updated")
            case .failure(let error):
                DDLogError("Fetch PlayingNow MovieList errror: \(error)")
                self.delegate?.errorHandling(error, self.getEmptyDataMessage())
            }
        }
    }
    
    public func fetchPopularMovies() {
        DDLogInfo("Start fetching Popular Movies")
        guard popularList.page < popularList.totalPages else {
            DDLogInfo("No more results for current list")
            return
        }
        let requestPage = popularList.page + 1
        let popularQueue = OperationQueue()
        popularQueue.addOperation {
            self.listService?.getPopularMovieList(for: requestPage, complition: self.popularMovieDetailsResultHandler)
        }
    }
    
    private func popularMovieDetailsResultHandler(result: Result<PopularDetailsList, ActionError>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let movieList):
                DDLogInfo("Popular Movies count: \(movieList.results.count)")
                self.popularList.page = movieList.page
                self.popularList.totalPages = movieList.totalPages
                self.popularList.results.append(contentsOf: movieList.results)
                
                self.dataSource?.popularCollection = self.popularList.results
                let indexPathsToReload = self.calculateIndexPathsToAdd(movieList.results.count)
                self.delegate?.movieListUpdated(with: indexPathsToReload, self.getEmptyDataMessage())
                DDLogInfo("Popular Movie List updated")
            case .failure(let error):
                DDLogError("Fetch Popular MovieList errror: \(error)")
                self.delegate?.errorHandling(error, self.getEmptyDataMessage())
            }
        }
    }
    
    
    // MARK: - NoDataView Message
    
    private func getEmptyDataMessage() -> NoDataMessage {
        return self.popularList.results.isEmpty ? .noDataFetched : .noMessage
    }
    
    // MARK: - IndexPaths
    
    private func handleSelectedIndexPath(_ indexPath: IndexPath?) {
        guard let selected = indexPath else { return }
        var movieDetails: MovieDetails?
        if self.popularList.results.indices.contains(selected.row) {
            movieDetails = self.popularList.results[selected.row]
        } else {
            movieDetails = nil
        }
        self.delegate?.showMovieDetails(movieDetails)
    }
    
    private func calculateIndexPathsToAdd(_ newMoviesCount: Int) -> [IndexPath]? {
        guard self.popularList.page > 1 else { return nil }
        let startIndex = self.popularList.results.count - newMoviesCount
        let endIndex = startIndex + newMoviesCount
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 1) }
    }
}
