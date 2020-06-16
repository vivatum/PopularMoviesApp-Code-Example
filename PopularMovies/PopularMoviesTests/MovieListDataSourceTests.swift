//
//  MovieListDataSourceTests.swift
//  PopularMoviesTests
//
//  Created by Vivatum on 16/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import XCTest

class MovieListDataSourceTests: XCTestCase {

    var dataSource: MovieListDataSource!
    
    override func setUp() {
        super.setUp()
        dataSource = MovieListDataSource()
    }
    
    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func testEmptyValueInDataSource() {
        let tableView = UITableView()
        tableView.dataSource = dataSource
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 2, "Expected TWO section in table view")
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 1, "Expected no ONE in table view")
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 1), 0, "Expected no cell in table view")
    }
}

