//
//  NetworkManager.swift
//  SportsApp
//
//  Created by ahmed on 17/05/2024.
//

import Foundation
import Alamofire
class NetworkManager : NetworkServiceProtocol{
    let API_KEY = "51d23fbecdf2c5bd3747bd385615b07c2435b5a78ea1b188c45391d1641d4610"
    let baseUrl = ""
    
    func fetchLeaguesData(sportName : String ,completion: @escaping (Result<LeagueResponse, Error>) -> Void) {
        let urlString = "https://apiv2.allsportsapi.com/\(sportName)/?met=Leagues&APIkey=\(API_KEY)"
        AF.request(urlString)
            .validate()
            .responseDecodable(of: LeagueResponse.self) { response in
                switch response.result {
                case .success(let leagueResponse):
                    completion(.success(leagueResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchUpcomingEvent(sportName : String , leagueId: Int, completion: @escaping (Result<UpcomingEventResponse, Error>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        guard let oneYearLaterDate = Calendar.current.date(byAdding: .year, value: 1, to: currentDate) else {
            completion(.failure("Network error badURL" as! Error))
            return
        }
        let currentDateString = dateFormatter.string(from: currentDate)
        let oneYearLaterDateString = dateFormatter.string(from: oneYearLaterDate)
        let urlString = "https://apiv2.allsportsapi.com/\(sportName)?met=Fixtures&leagueId=\(leagueId)&from=\(currentDateString)&to=\(oneYearLaterDateString)&APIkey=\(API_KEY)"
        
        AF.request(urlString)
            .validate()
            .responseDecodable(of: UpcomingEventResponse.self) { response in
                switch response.result {
                case .success(let fixtureResponse):
                    completion(.success(fixtureResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchLiveMatchResults(sportName : String , leagueId: Int, completion: @escaping (Result<LiveMatchResponse, any Error>) -> Void) {
        let urlString = "https://apiv2.allsportsapi.com/\(sportName)?met=Livescore&leagueId=\(leagueId)&APIkey=\(API_KEY)"
        AF.request(urlString)
            .validate()
            .responseDecodable(of: LiveMatchResponse.self) { response in
                switch response.result {
                case .success(let fixtureResponse):
                    completion(.success(fixtureResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchTeams(sportName: String, leagueId: Int, completion: @escaping (Result<TeamResponse, any Error>) -> Void) {
        let urlString = "https://apiv2.allsportsapi.com/\(sportName)/?met=Teams&leagueId=\(leagueId)&APIkey=\(API_KEY)"

        AF.request(urlString)
            .validate()
            .responseDecodable(of: TeamResponse.self) { response in
                switch response.result {
                case .success(let teamResponse):
                    completion(.success(teamResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchTeamDetails(sportName: String, teamId: Int, completion: @escaping (Result<TeamDetailsResponse, any Error>) -> Void) {
        let urlString = "https://apiv2.allsportsapi.com/\(sportName)/?met=Teams&teamId=\(teamId)&APIkey=\(API_KEY)"
        AF.request(urlString)
            .validate()
            .responseDecodable(of: TeamDetailsResponse.self) { response in
                switch response.result {
                case .success(let teamResponse):
                    completion(.success(teamResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        
    }
    
    func fetchLatest(sportName: String, leagueId: Int, completion: @escaping (Result<LiveMatchResponse, Error>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        
        // Calculate one month earlier date
        guard let oneMonthEarlierDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) else {
            completion(.failure("Network error: Unable to calculate date" as! Error))
            return
        }
        
        let currentDateString = dateFormatter.string(from: currentDate)
        let oneMonthEarlierDateString = dateFormatter.string(from: oneMonthEarlierDate)
        
        let urlString = "https://apiv2.allsportsapi.com/\(sportName)?met=Fixtures&leagueId=\(leagueId)&from=\(oneMonthEarlierDateString)&to=\(currentDateString)&APIkey=\(API_KEY)"
        
        AF.request(urlString)
            .validate()
            .responseDecodable(of: LiveMatchResponse.self) { response in
                switch response.result {
                case .success(let fixtureResponse):
                    completion(.success(fixtureResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    
    
}


