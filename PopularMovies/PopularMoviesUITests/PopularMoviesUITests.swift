//
//  PopularMoviesUITests.swift
//  PopularMoviesUITests
//
//  Created by Vivatum on 14/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import XCTest

class PopularMoviesUITests: XCTestCase {

    let cell_0_0_ID = "movie_0_0"
    let cell_1_0_ID = "movie_1_0"
    
    var app: XCUIApplication!
    
    override func setUp() {
       continueAfterFailure = false

      app = XCUIApplication()
      app.launch()
    }
    
    func testForCellExistenceFirstSection() {
        let listTable = app.tables.matching(identifier: TableViewIdentifier.movieTableViewId)
        let firstCell = listTable.cells.element(matching: .cell, identifier: cell_0_0_ID)
        let existencePredicate = NSPredicate(format: "exists == 1")
        let expectationEval = expectation(for: existencePredicate, evaluatedWith: firstCell, handler: nil)
        let mobWaiter = XCTWaiter.wait(for: [expectationEval], timeout: 10.0)
        XCTAssert(XCTWaiter.Result.completed == mobWaiter, "Test Case Failed.")
    }
    
    func testForCellExistenceSecondSection() {
        let listTable = app.tables.matching(identifier: TableViewIdentifier.movieTableViewId)
        let firstCell = listTable.cells.element(matching: .cell, identifier: cell_1_0_ID)
        let existencePredicate = NSPredicate(format: "exists == 1")
        let expectationEval = expectation(for: existencePredicate, evaluatedWith: firstCell, handler: nil)
        let mobWaiter = XCTWaiter.wait(for: [expectationEval], timeout: 10.0)
        XCTAssert(XCTWaiter.Result.completed == mobWaiter, "Test Case Failed.")
    }
    
    func testForCellSelection() {
        let listTable = app.tables.matching(identifier: TableViewIdentifier.movieTableViewId)
        let firstCell = listTable.cells.element(matching: .cell, identifier: cell_1_0_ID)
        let predicate = NSPredicate(format: "isHittable == true")
        let expectationEval = expectation(for: predicate, evaluatedWith: firstCell, handler: nil)
        let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 10.0)
        XCTAssert(XCTWaiter.Result.completed == waiter, "Test Case Failed.")
        firstCell.tap()
    }
    
    func testElementsExistenceOnTableCell() {
        let listTable = app.tables.matching(identifier: TableViewIdentifier.movieTableViewId)
        let firstCell = listTable.cells.element(matching: .cell, identifier: cell_1_0_ID)
        XCTAssertTrue(firstCell.exists, "Table view cell not exist.")
        
        let titleLabel = firstCell.staticTexts[MovieDetailsUIId.titleLabel]
        XCTAssertTrue(titleLabel.exists, "Title label not exist.")
        let dateLabel = firstCell.staticTexts[MovieDetailsUIId.dateLabel]
        XCTAssertTrue(dateLabel.exists, "Date label not exist.")
        let rantimeLabel = firstCell.staticTexts[MovieDetailsUIId.runtimeLabel]
        XCTAssertTrue(rantimeLabel.exists, "Rantime label not exist.")
        
        let posterImageView = firstCell.images[MovieDetailsUIId.posterImageView].firstMatch
        XCTAssertTrue(posterImageView.exists, "Poster Image view not exist.")
        let ratingView = firstCell.otherElements[MovieDetailsUIId.ratingView].firstMatch
        XCTAssertTrue(ratingView.exists, "Rating view not exist.")
        let customSeparatorView = firstCell.otherElements[MovieDetailsUIId.customSeparatorView].firstMatch
        XCTAssertTrue(customSeparatorView.exists, "Separator view not exist.")
    }
}
