//
//  MockNetworkTest.swift
//  SportsAppTests
//
//  Created by ahmed on 27/05/2024.
//

import XCTest

final class MockNetworkTest: XCTestCase {
    var mockNetwork : MockNetworkManager?
    override func setUpWithError() throws {
        mockNetwork = MockNetworkManager()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        mockNetwork = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchLeagueDataSuccess(){
        mockNetwork?.jsonString = mockSuccessJSON
        mockNetwork?.fetchLeaguesData(completion: { result in
            switch result{
                
            case .success(let response):
                XCTAssertEqual(response.result?.count, 2)
            case .failure(let error):
                XCTFail("Expected success but got failure with error: \(error)")
            }
        })
    }

}
