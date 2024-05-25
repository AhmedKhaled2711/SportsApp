//
//  LeagueDetailsViewModel.swift
//  SportsApp
//
//  Created by Ahmed Khaled on 22/05/2024.
//

import Foundation
class LeagueDetailsViewModel{
    var network : NetworkServiceProtocol?
    var listOfUpcomingEvents : [UpcomingEvent]?{
        didSet{
            dataBinder()
        }
    }
    var listOfResults : [liveMatchResult]?{
        didSet{
            dataBinder2()
        }
    }
    init(network : NetworkServiceProtocol) {
        self.network = network
    }
    var dataBinder : () -> () = {}
    var dataBinder2 : () -> () = {}

    func fetchUpcomingEvents(sportName : String , leagueId : Int){
        network?.fetchUpcomingEvent(sportName : sportName , leagueId: leagueId){ [weak self] result in
            switch result{
            case .success(let upcomingEventsResponse):
                self?.listOfUpcomingEvents = upcomingEventsResponse.result
            case .failure(let error):
                print("Error: "+error.localizedDescription)
            }
        }
    }
    
    func fetchResults(sportName : String , leagueId : Int){
        network?.fetchLiveMatchResults(sportName : sportName , leagueId: leagueId){ [weak self] result in
            switch result{
            case .success(let liveMatchResponse):
                self?.listOfResults = liveMatchResponse.result
            case .failure(let error):
                print("Error: "+error.localizedDescription)
            }
        }
    }
}
