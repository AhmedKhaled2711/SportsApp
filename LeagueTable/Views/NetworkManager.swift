//
//  NetworkManager.swift
//  SportsApp
//
//  Created by ahmed on 17/05/2024.
//

import Foundation
import Alamofire
class NetworkManager{
    let API_KEY = "22dda350e03f8f59a082bcf441d5cb29a48277d786b6c3abe6197bc43205fab8"
    let baseUrl = ""
    func fetchLeaguesData(completion: @escaping (Result<LeagueResponse, Error>) -> Void) {
        let urlString = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=\(API_KEY)"
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
}
