//
//  NetworkManager.swift
//  SportsApp
//
//  Created by ahmed on 17/05/2024.
//

import Foundation
import Alamofire
class NetworkManager : NetworkServiceProtocol{
    let API_KEY = "22dda350e03f8f59a082bcf441d5cb29a48277d786b6c3abe6197bc43205fab8"
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
    
    func fetchLiveMatchResults(sportName : String , leagueId: Int, completion: @escaping (Result<liveMatchResponse, any Error>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        guard let oneYearLaterDate = Calendar.current.date(byAdding: .year, value: -1, to: currentDate) else {
            completion(.failure("Network error badURL" as! Error))
            return
        }
        let currentDateString = dateFormatter.string(from: currentDate)
        let oneYearLaterDateString = dateFormatter.string(from: oneYearLaterDate)
        
        let urlString = "https://apiv2.allsportsapi.com/\(sportName)?met=Livescore&leagueId=\(leagueId)&APIkey=\(API_KEY)"
        AF.request(urlString)
            .validate()
            .responseDecodable(of: liveMatchResponse.self) { response in
                switch response.result {
                case .success(let fixtureResponse):
                    completion(.success(fixtureResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
