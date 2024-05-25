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
struct liveMatchResponse: Decodable {
    let success: Int?
    let result: [liveMatchResult]?
}


struct liveMatchResult: Decodable {
    let event_home_team, event_away_team, event_final_result, home_team_logo, away_team_logo: String?
    let event_date, event_time: String?
}
