//
//  LeagueDetailsResponse.swift
//  SportsApp
//
//  Created by Ahmed Khaled on 20/05/2024.
//

import Foundation

struct UpcomingEventResponse: Decodable {
    let success: Int?
    let result: [UpcomingEvent]?
}


struct UpcomingEvent: Decodable {
    let event_date, event_time, event_home_team, event_away_team, home_team_logo, away_team_logo: String?
    }
