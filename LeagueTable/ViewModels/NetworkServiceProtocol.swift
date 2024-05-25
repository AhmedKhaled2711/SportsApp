//
//  NetworkServiceProtocol.swift
//  SportsApp
//
//  Created by ahmed on 18/05/2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchLeaguesData(sportName : String ,completion: @escaping (Result<LeagueResponse, Error>) -> Void)
    func fetchUpcomingEvent(sportName : String , leagueId: Int, completion: @escaping (Result<UpcomingEventResponse, Error>) -> Void)
    func fetchLiveMatchResults(sportName : String , leagueId: Int, completion: @escaping (Result<LiveMatchResponse, Error>) -> Void)
    func fetchTeams(sportName : String , leagueId: Int ,completion: @escaping (Result<TeamResponse, Error>) -> Void)
    func fetchTeamDetails(sportName : String , teamId: Int ,completion: @escaping (Result<TeamDetailsResponse, Error>) -> Void)
    func fetchLatest(sportName : String , leagueId: Int, completion: @escaping (Result<LiveMatchResponse, Error>) -> Void)
}
