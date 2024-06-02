//
//  LeagueResponse.swift
//  SportsApp
//
//  Created by ahmed on 17/05/2024.
//

import Foundation

public class LeagueResponse: Decodable {
    public var success: Int?
    public var result: [LeagueItem]?
    
    public init(success: Int? = nil, result: [LeagueItem]? = nil) {
        self.success = success
        self.result = result
    }
}

public class LeagueItem: Decodable {
    public var league_name: String?
    public var league_logo: String?
    public var youtube: String?
    public var league_key: Int?
    public var sportName : String?
    
    public init(league_name: String? = nil, league_logo: String? = nil, youtube: String? = nil, league_key: Int? = nil, sportName : String? = nil) {
        self.league_name = league_name
        self.league_logo = league_logo
        self.youtube = youtube
        self.league_key = league_key
        self.sportName = sportName
    }
}

