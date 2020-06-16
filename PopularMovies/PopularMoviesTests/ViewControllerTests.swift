//
//  ViewControllerTests.swift
//  PopularMoviesTests
//
//  Created by Vivatum on 16/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import XCTest

class ViewControllerTests: XCTestCase {
    
    var controller: MovieListViewController!
    var tableView: UITableView!
    
    
    override func setUp() {
        super.setUp()

        let storyboard: UIStoryboard = UIStoryboard(name: "Movie", bundle: Bundle(for: MovieListViewController.self))
        guard let listController = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController else {
            return XCTFail("Could not instantiate MovieListViewController from Movie storyboard")
        }

        controller = listController
        controller.loadViewIfNeeded()
        
        XCTAssertNotNil(controller.tableView, "Controller should have a tableview")
        tableView = controller.tableView
    }
    
    override func tearDown() {
        self.controller = nil
        self.tableView = nil
        super.tearDown()
    }
    
    func testTableViewHasCells() {
        let playingNowCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.playingNow)
        XCTAssertNotNil(playingNowCell, "TableView should be able to dequeue cell with identifier: 'PlayingNowCell'")
        let popularCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.popular)
        XCTAssertNotNil(popularCell, "TableView should be able to dequeue cell with identifier: 'PopularCell'")
    }
    
    func testTableViewDelegateIsViewController() {
        XCTAssertFalse(tableView.delegate === controller, "Controller should NOT be delegate for the table view")
    }
}
