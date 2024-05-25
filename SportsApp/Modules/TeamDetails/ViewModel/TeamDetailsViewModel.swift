//
//  TeamDetailsViewModel.swift
//  SportsApp
//
//  Created by Ahmed Khaled on 25/05/2024.
//

import Foundation
class TeamDetailsViewModel{
    var network : NetworkServiceProtocol?
    var teamDetails : [TeamDetailsItem]?{
        didSet{
            dataBinder()
        }
    }
    init(network : NetworkServiceProtocol) {
        self.network = network
    }
    var dataBinder : () -> () = {}
    
    func getTeamDetails(sportName: String, teamId: Int){
        network?.fetchTeamDetails(sportName: sportName, teamId: teamId){ [weak self] result in
                switch result{
                    case .success(let leagueResponse):
                        self?.teamDetails = leagueResponse.result
                    case .failure(let error):
                        print("Error: "+error.localizedDescription)
                }
            }
            
        }
}


