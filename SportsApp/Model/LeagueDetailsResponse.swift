//
//  LeagueDetailsResponse.swift
//  SportsApp
//
//  Created by Ahmed Khaled on 20/05/2024.
//

import Foundation
// Upcoming Event
struct UpcomingEventResponse: Decodable {
    let success: Int?
    let result: [UpcomingEvent]?
}


struct UpcomingEvent: Decodable {
    let event_date, event_time, event_home_team, event_away_team, home_team_logo, away_team_logo: String?
}

// live Match
struct LiveMatchResponse: Decodable {
    let success: Int?
    let result: [LiveMatchResult]?
}


struct LiveMatchResult: Decodable {
    let event_home_team, event_away_team, event_final_result, home_team_logo, away_team_logo: String?
    let event_date, event_time: String?
}

//teams
struct TeamResponse: Decodable {
    let success: Int?
    let result: [Team]?
}


struct Team: Decodable {
    let  team_name, team_logo: String?
    let team_key : Int?
    
}

