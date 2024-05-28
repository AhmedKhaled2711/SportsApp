//
//  NetworkManager.swift
//  SportsAppTests
//
//  Created by Ahmed Khaled on 27/05/2024.
//

import XCTest
@testable import SportsApp


final class NetworkManagerTest: XCTestCase {
    var networkManager: NetworkServiceProtocol!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkManager = NetworkManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkManager = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchLeaguesData() {
        let expectation = expectation(description: "Wait for fetching leagues data ..")
        let sportName = "football"
        
        networkManager.fetchLeaguesData(sportName: sportName) { result in
            switch result {
            case .success(let leagueResponse):
                XCTAssertNotNil(leagueResponse)
                XCTAssertEqual(leagueResponse.result?.count, 865,"Error in retrive array")
                // Add assertions for leagueResponse
                
            case .failure(let error):
                XCTFail("Failed to fetch leagues data with error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        }
        
    func testFetchUpcomingEvent() {
        let expectation = expectation(description: "Wait for fetching upcoming event data ..")
        let sportName = "football"
        let leagueId = 123
        
        networkManager.fetchUpcomingEvent(sportName: sportName, leagueId: leagueId) { result in
            switch result {
            case .success(let upcomingEventResponse):
                XCTAssertNotNil(upcomingEventResponse)
                // Add assertions for upcomingEventResponse
                
            case .failure(let error):
                XCTFail("Failed to fetch upcoming event data with error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchLiveMatchResults() {
        let expectation = expectation(description: "Wait for fetching live match results data ..")
        let sportName = "football"
        let leagueId = 123
        
        networkManager.fetchLiveMatchResults(sportName: sportName, leagueId: leagueId) { result in
            switch result {
            case .success(let liveMatchResponse):
                XCTAssertNotNil(liveMatchResponse)
                // Add assertions for liveMatchResponse
                
            case .failure(let error):
                XCTFail("Failed to fetch live match results data with error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchTeams() {
        let expectation = expectation(description: "Wait for fetching teams data ..")
        let sportName = "football"
        let leagueId = 123
        
        networkManager.fetchTeams(sportName: sportName, leagueId: leagueId) { result in
            switch result {
            case .success(let teamResponse):
                XCTAssertNotNil(teamResponse)
                // Add assertions for teamResponse
                
            case .failure(let error):
                XCTFail("Failed to fetch teams data with error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchTeamDetails() {
        let expectation = expectation(description: "Wait for fetching team details data ..")
        let sportName = "football"
        let teamId = 123
        
        networkManager.fetchTeamDetails(sportName: sportName, teamId: teamId) { result in
            switch result {
            case .success(let teamDetailsResponse):
                XCTAssertNotNil(teamDetailsResponse)
                // Add assertions for teamDetailsResponse
                
            case .failure(let error):
                XCTFail("Failed to fetch team details data with error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchLatest() {
        let expectation = expectation(description: "Wait for fetching latest data ..")
        let sportName = "football"
        let leagueId = 123
        
        networkManager.fetchLatest(sportName: sportName, leagueId: leagueId) { result in
            switch result {
            case .success(let liveMatchResponse):
                XCTAssertNotNil(liveMatchResponse)
                // Add assertions for liveMatchResponse
                
            case .failure(let error):
                XCTFail("Failed to fetch latest data with error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

}
