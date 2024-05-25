//
//  FavoriteViewModel.swift
//  SportsApp
//
//  Created by ahmed on 21/05/2024.
//

import Foundation
class FavoriteViewModel{
    
    var dataBase : DataBaseProtocol?
    init(dataBase: DataBaseProtocol?) {
        self.dataBase = dataBase
    }
    
    func getFavoriteLeaguesList() -> [LeagueItem]?{
        return dataBase?.fetchFavoriteLeagues()
    }
    
    func deleteLeagueFromFavorite(league : LeagueItem?){
        dataBase?.deleteLeagueFromFavorite(league: league)
    }
    
}
