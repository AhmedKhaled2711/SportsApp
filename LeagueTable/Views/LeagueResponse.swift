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
}
