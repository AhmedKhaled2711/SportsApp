//
//  Database.swift
//  SportsAppTests
//
//  Created by Ahmed Khaled on 27/05/2024.
//

import XCTest
@testable import SportsApp

final class DatabaseTest: XCTestCase {
    var database: DataBaseProtocol!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        database = DataBase()
        database.deleteAll()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        database = nil
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
    
    func testsaveLeagueToDataBase() {
        let favLeague = LeagueItem(league_name: "Premier League", league_logo: "premier_league_logo.png", league_key: 1)
        database.saveLeagueToDataBase(league: favLeague)
        
        let results = database.fetchFavoriteLeagues()
        XCTAssertEqual(results?.count, 1, "There should be one entry in the context")
    }
    
    func testFetchFavoriteLeagues(){
        let favLeague1 = LeagueItem(league_name: "Premier League", league_logo: "premier_league_logo.png", league_key: 1)
        let favLeague2 = LeagueItem(league_name: "NBA", league_logo: "nba_logo.png", league_key: 2)
        
        database.saveLeagueToDataBase(league: favLeague1)
        database.saveLeagueToDataBase(league: favLeague2)

        let results = database.fetchFavoriteLeagues()
        XCTAssertEqual(results?.count, 2, "There should be two entries in the context")
    }
    
    func testDeleteLeagueFromFavorite(){
        let favLeague = LeagueItem(league_name: "Premier League", league_logo: "premier_league_logo.png", league_key: 1)
        database.saveLeagueToDataBase(league: favLeague)
        
        var results = database.fetchFavoriteLeagues()
        XCTAssertEqual(results?.count, 1, "There should be one entry in the context before deletion")

        database.deleteLeagueFromFavorite(league: favLeague)

        results = database.fetchFavoriteLeagues()
        XCTAssertEqual(results?.count, 0, "There should be no entries in the context after deletion")
        
    }
    
    func testCheckIfFavorite() {
        let favLeague = LeagueItem(league_name: "Premier League", league_logo: "premier_league_logo.png", league_key: 1)
        database.saveLeagueToDataBase(league: favLeague)

        let isFavorite = database.checkIfFavorite(league: favLeague)
        XCTAssertTrue(isFavorite, "Premier League should be marked as favorite")
        
        let nonFavLeague = LeagueItem(league_name: "La Liga", league_logo: "la_liga_logo.png", league_key: 2)
        let isNonFavorite = database.checkIfFavorite(league: nonFavLeague)
        XCTAssertFalse(isNonFavorite, "La Liga should not be marked as favorite")
    }

    
    func testDeleteAll(){
        let favLeague = LeagueItem(league_name: "Premier League", league_logo: "premier_league_logo.png", league_key: 1)
        database.saveLeagueToDataBase(league: favLeague)
        
        database.deleteAll()

        let results = database.fetchFavoriteLeagues()
        XCTAssertEqual(results?.count, 0, "There should be no entries in the context after deletion")
    }
    
    
    

}
