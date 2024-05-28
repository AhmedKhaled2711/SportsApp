//
//  DataBaseProtocol.swift
//  SportsApp
//
//  Created by ahmed on 20/05/2024.
//

import Foundation

protocol DataBaseProtocol{
    func saveLeagueToDataBase(league : LeagueItem , sportName : String) -> Void
    func fetchFavoriteLeagues() -> [LeagueItem]?
    func deleteLeagueFromFavorite(league : LeagueItem?) -> Void
    func checkIfFavorite(league: LeagueItem) -> Bool
    func deleteAll()
}
