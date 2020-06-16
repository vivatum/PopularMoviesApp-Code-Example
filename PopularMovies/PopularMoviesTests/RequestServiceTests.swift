//
//  RequestServiceTests.swift
//  PopularMoviesTests
//
//  Created by Vivatum on 14/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import XCTest

class RequestServiceTests: XCTestCase {

    var mockSession: NetworkSessionMock!
    var service: RequestService!
    
    override func setUp() {
        super.setUp()
        mockSession = NetworkSessionMock()
        service = RequestService(session: mockSession)
    }
    
    override func tearDown() {
        mockSession = nil
        service = nil
        super.tearDown()
    }
    
    func testSuccessfulResponse() {
        let data = Data()
        mockSession.data = data
        guard let url = URLFactory.moviesNowPlayingRequestURL() else {
            fatalError("URL can't be empty")
        }
        let completion: ((Result<Data, ActionError>) -> Void) = { result in
            switch result {
            case .success(_):
                XCTAssertEqual(result, .success(data))
            default:
                break
            }
        }
        service.loadData(url: url, completion: completion)
    }
    
    func testExpectedFailedResponse() {
        mockSession.data = nil
        guard let url = URLFactory.moviesNowPlayingRequestURL() else {
            fatalError("URL can't be empty")
        }
        let expectedError = ActionError.network("An error occured during request")
        let completion: ((Result<Data, ActionError>) -> Void) = { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, expectedError, "Expected error when no data")
            default:
                break
            }
        }
        service.loadData(url: url, completion: completion)
    }

}
