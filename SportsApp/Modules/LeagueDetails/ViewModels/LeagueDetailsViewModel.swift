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
            dataBinderUpcomingEvents()
        }
    }
    var listOfResults : [LiveMatchResult]?{
        didSet{
            dataBinderResults()
        }
    }
    var listOfTeams : [Team]?{
        didSet{
            dataBinderTeams()
        }
    }
    init(network : NetworkServiceProtocol) {
        self.network = network
    }
    var dataBinderUpcomingEvents : () -> () = {}
    var dataBinderResults : () -> () = {}
    var dataBinderTeams : () -> () = {}
    
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
    
    func fetchTeams(sportName : String , leagueId : Int){
        network?.fetchTeams(sportName: sportName, leagueId: leagueId){ [weak self] result in
            switch result{
            case .success(let teamResponse):
                self?.listOfTeams = teamResponse.result
            case .failure(let error):
                print("Error: "+error.localizedDescription)
            }
        }}
}
