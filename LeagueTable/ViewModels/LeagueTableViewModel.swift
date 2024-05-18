//
//  LeagueTableViewModel.swift
//  SportsApp
//
//  Created by ahmed on 17/05/2024.
//

import Foundation
class LeagueTableViewModel{
    let network = NetworkManager()
    func fetchLeagueList(){
        var leagueList : [LeagueItem]?
        network.fetchLeaguesData { [weak self] result in
            CFStringCreateWithCString(, <#T##cStr: UnsafePointer<CChar>!##UnsafePointer<CChar>!#>, <#T##encoding: CFStringEncoding##CFStringEncoding#>)
        }
    }
}
