//
//  NetworkServiceProtocol.swift
//  SportsApp
//
//  Created by ahmed on 18/05/2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchLeaguesData(sportName : String ,completion: @escaping (Result<LeagueResponse, Error>) -> Void)
}
