//
//  LeagueResponse.swift
//  SportsApp
//
//  Created by ahmed on 17/05/2024.
//

import Foundation
class LeagueResponse: Decodable {
    var success : Int?
    var result : [LeagueItem]?
}

class LeagueItem: Decodable{
    var league_name, league_logo : String?
    var youtube : String?
    var league_key: Int?
    init(league_name: String? = nil, league_logo: String? = nil, youtube: String? = nil, league_key: Int? = nil) {
        self.league_name = league_name
        self.league_logo = league_logo
        self.youtube = youtube
        self.league_key = league_key
    }
}
