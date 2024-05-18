//
//  LeagueTableViewModel.swift
//  SportsApp
//
//  Created by ahmed on 17/05/2024.
//

import Foundation
class LeagueTableViewModel{
    let network = NetworkManager()
    var leagueList : [LeagueItem]?{
        didSet{
            dataBinder()
        }
    }
    var dataBinder : () -> () = {}
    func fetchLeagueList(sportName : String){
        network.fetchLeaguesData(sportName : sportName) { [weak self] result in
            switch result{
            case .success(let leagueResponse):
                self?.leagueList = leagueResponse.result
            case .failure(let error):
                print("Error: "+error.localizedDescription)
            }
        }
    }
}
