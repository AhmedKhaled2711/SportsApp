//
//  LeagueDetailsViewModelDatabase.swift
//  SportsApp
//
//  Created by Ahmed Khaled on 23/05/2024.
//

import Foundation
class LeagueDetailsViewModelDatabase{
    
    var dataBase : DataBaseProtocol?
    init(dataBase: DataBaseProtocol?) {
        self.dataBase = dataBase
    }
    
    func deleteLeagueFromFavorite(league : LeagueItem?){
        dataBase?.deleteLeagueFromFavorite(league: league)
    }
    
    func saveLeagueToFavorite(league : LeagueItem?){
        dataBase?.saveLeagueToDataBase(league: league!)
    }
    
    func checkIfFavorite(league: LeagueItem)  -> Bool{
        ((dataBase?.checkIfFavorite(league: league)) != nil)
    }
    
}
