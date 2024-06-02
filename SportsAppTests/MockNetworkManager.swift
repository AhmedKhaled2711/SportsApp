//
//  MockNetworkManager.swift
//  SportsAppTests
//
//  Created by ahmed on 27/05/2024.
//

import Foundation
@testable import SportsApp
public class MockNetworkManager {
    public var jsonString: String?
    
    public init() {}
    
    public func fetchLeaguesData(completion: @escaping (Result<LeagueResponse, Error>) -> Void) {
        guard let jsonString = jsonString else {
            completion(.failure(MockError.invalidData))
            return
        }
        
        let data = Data(jsonString.utf8)
        do {
            let response = try JSONDecoder().decode(LeagueResponse.self, from: data)
            completion(.success(response))
        } catch {
            completion(.failure(error))
        }
    }
}

public enum MockError: Error {
    case mockFailure
    case invalidData
}

let mockSuccessJSON = """
{
    "success": 1,
    "result": [
        {
            "league_name": "Premier League",
            "league_logo": "logo1.png",
            "youtube": "youtube1",
            "league_key": 1
        },
        {
            "league_name": "La Liga",
            "league_logo": "logo2.png",
            "youtube": "youtube2",
            "league_key": 2
        }
    ]
}
"""

let mockFailureJSON = """
{
    "success": 0,
    "result": []
}
"""
