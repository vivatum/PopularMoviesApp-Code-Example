//
//  MovieListViewModelTests.swift
//  PopularMoviesTests
//
//  Created by Vivatum on 16/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import XCTest
import CocoaLumberjackSwift


class MovieListViewModelTests: XCTestCase {

    var viewModel: MovieListViewModel!
    var dataSource: MovieListDataSource!
    fileprivate var mockViewController = MockViewController()
    fileprivate var service : MockMovieListService!
    
    override func setUp() {
        super.setUp()
        
        self.service = MockMovieListService()
        self.dataSource = MovieListDataSource()
        
        self.viewModel = MovieListViewModel(
            dataSource: dataSource,
            listService: service)
        self.viewModel.delegate = self.mockViewController
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.dataSource = nil
        self.service = nil
        super.tearDown()
    }
    
    func testPlayingNowListFailedReaction() {
        self.service.playingNowList = nil
        let expectation = XCTestExpectation(description: "Expectation: Error Reseived")
        self.mockViewController.errorReaction = {
            DDLogInfo("Expectation: Error Reseived")
            expectation.fulfill()
        }
        self.viewModel.fetchPlayingNowMovies()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testPlayingNowListReceivedReaction() {
        self.service.playingNowList = [PlayingNow]()
        let expectation = XCTestExpectation(description: "Expectation: Array received")
        self.mockViewController.playingNowMoviesReaction = {
            DDLogInfo("Expectation: Array received")
            expectation.fulfill()
        }
        self.viewModel.fetchPlayingNowMovies()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testPopolarListFailedReaction() {
        self.service.popularList = nil
        let expectation = XCTestExpectation(description: "Expectation: Error Reseived")
        self.mockViewController.errorReaction = {
            DDLogInfo("Expectation: Error Reseived")
            expectation.fulfill()
        }
        self.viewModel.fetchPopularMovies()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testPopolarListReceivedReaction() {
        self.service.popularList = PopularDetailsList(results: [MovieDetails](), page: 1, totalPages: 1)
        let expectation = XCTestExpectation(description: "Expectation: PopularDetailsList received")
        self.mockViewController.popularMoviesReaction = {
            DDLogInfo("Expectation: PopularDetailsList received")
            expectation.fulfill()
        }
        self.viewModel.fetchPopularMovies()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testMovieSelectedReaction() {
        let indexPath = IndexPath(row: 1, section: 1)
        let expectation = XCTestExpectation(description: "Expectation: Selected Movie received")
        self.mockViewController.selectedMovieReaction = {
            DDLogInfo("Expectation: Selected Movie received")
            expectation.fulfill()
        }
        self.viewModel.selectedIndexPath = indexPath
        wait(for: [expectation], timeout: 1.0)
    }
}

fileprivate class MockMovieListService: MovieListServiceProtocol {
    
    var playingNowList: [PlayingNow]?
    var popularList: PopularDetailsList?
    
    func getPlayingNowMovieList(complition: @escaping (Result<[PlayingNow], ActionError>) -> Void) {
        if let playingList = playingNowList {
            complition(.success(playingList))
        } else {
            complition(.failure(.custom("errorMessage")))
        }
    }
    
    func getPopularMovieList(for page: Int, complition: @escaping (Result<PopularDetailsList, ActionError>) -> Void) {
        if let detailsList = popularList {
            complition(.success(detailsList))
        } else {
            complition(.failure(.custom("errorMessage")))
        }
    }
}

fileprivate class MockViewController: MovieViewModelDelegate {
    
    var playingNowMoviesReaction: (() -> Void)?
    var popularMoviesReaction: (() -> Void)?
    var selectedMovieReaction: (() -> Void)?
    var errorReaction: (() -> Void)?
    
    func posterListUpdated(_ posterList: [PlayingNow]) {
        self.playingNowMoviesReaction?()
    }
    
    func movieListUpdated(with newIndexPathsToReload: [IndexPath]?, _ noDataMessage: NoDataMessage) {
        self.popularMoviesReaction?()
    }
    
    func showMovieDetails(_ movie: MovieDetails?) {
        self.selectedMovieReaction?()
    }
    
    func errorHandling(_ error: ActionError?, _ noDataMessage: NoDataMessage) {
        self.errorReaction?()
    }
    
}

