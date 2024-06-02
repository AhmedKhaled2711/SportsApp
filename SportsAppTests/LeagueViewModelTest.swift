//
//  LeagueViewModelTest.swift
//  SportsAppTests
//
//  Created by ahmed on 27/05/2024.
//

import XCTest
@testable import SportsApp
final class LeagueViewModelTest: XCTestCase {
    
    var viewModel : LeagueTableViewModel?
    override func setUpWithError() throws {
        viewModel = LeagueTableViewModel(network: NetworkManager())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        viewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchLeagueList(){	
        let expectation = self.expectation(description: "Data Binding")
        viewModel?.fetchLeagueList(sportName: "football")
        viewModel?.dataBinder = { [weak self] () in
            expectation.fulfill()
            XCTAssertEqual(self?.viewModel?.leagueList?.count, 865)
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
