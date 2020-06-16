//
//  MovieRequestHandlerTests.swift
//  PopularMoviesTests
//
//  Created by Vivatum on 14/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import XCTest

class MovieRequestHandlerTests: XCTestCase {

    var movieRequestHandler: MovieRequestHandler!
    
    override func setUp() {
      super.setUp()
      movieRequestHandler = MovieRequestHandler()
    }

    override func tearDown() {
      movieRequestHandler = nil
      super.tearDown()
    }
    
    func testPopularIdListParsing() {
        let jsonFileName = "popular"
        let expectedItemsCount = 20
        
        guard let responseData = JSONReader.readJSON(forResource: jsonFileName) else {
            XCTFail("ResponseData can't be empty")
            return
        }
        
        movieRequestHandler.parseMovieIdList(responseData) { result in
            switch result {
            case .success(let movieInfo):
                XCTAssertEqual(expectedItemsCount, movieInfo.items.count)
            default:
                break
            }
        }
    }

    func testPopularIdListParsingFailed() {
        let expectedError = ActionError.parser("Can't parse Movie List")
        movieRequestHandler.parseMovieIdList(Data()) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, expectedError, "Expected error when no data")
            default:
                break
            }
        }
    }

    func testPlayingNowListParsing() {
        let jsonFileName = "now_playing"
        let expectedItemsCount = 20
        guard let responseData = JSONReader.readJSON(forResource: jsonFileName) else {
            XCTFail("ResponseData can't be empty")
            return
        }
        movieRequestHandler.parsePlayingNow(responseData) { result in
            switch result {
            case .success(let movieArray):
                XCTAssertEqual(expectedItemsCount, movieArray.count)
            default:
                break
            }
        }
    }

    func testPlayingNowListParsingFailed() {
        let expectedError = ActionError.parser("Can't parse PlayingNow Movie List")
        movieRequestHandler.parsePlayingNow(Data()) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, expectedError, "Expected error when no data")
            default:
                break
            }
        }
    }

    func testMovieDetailsParsing() {
        let jsonFileName = "movie"
        let expectedMovieId = 22
        guard let responseData = JSONReader.readJSON(forResource: jsonFileName) else {
            XCTFail("ResponseData can't be empty")
            return
        }
        movieRequestHandler.parseMovieDetails(responseData) { result in
            switch result {
            case .success(let movie):
                XCTAssertEqual(expectedMovieId, movie.id)
            default:
                break
            }
        }
    }

    func testMovieDetailsParsingFailed() {
        let expectedError = ActionError.parser("Can't parse Movie Details")
        movieRequestHandler.parseMovieDetails(Data()) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, expectedError, "Expected error when no data")
            default:
                break
            }
        }
    }

}
