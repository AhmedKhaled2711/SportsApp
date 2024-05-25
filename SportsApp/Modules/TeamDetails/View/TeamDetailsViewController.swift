//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Ahmed Khaled on 25/05/2024.
//

import UIKit

class TeamDetailsViewController: UIViewController ,  UITableViewDelegate,UITableViewDataSource {
    
    var teamKey : Int?
    var sportName : String?
    let teamDetailsViewModel = TeamDetailsViewModel(network: NetworkManager()) // Need to implement dependency incjection later
    var teamDetailsList : [TeamDetailsItem]?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var coachName: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        teamDetailsViewModel.getTeamDetails(sportName: self.sportName!.lowercased(), teamId: teamKey!)
        teamDetailsViewModel.dataBinder = { [weak self] () in
            self?.teamDetailsList = self?.teamDetailsViewModel.teamDetails
            self?.tableView.reloadData()
            
            // Update UI elements after data is loaded
            if let teamDetails = self?.teamDetailsList?.first {
                self?.teamName.text = teamDetails.team_name
                self?.coachName.text = teamDetails.coaches?.first?.coach_name
                self?.teamImage.kf.setImage(with: URL(string: teamDetails.team_logo ?? ""), placeholder: UIImage(named: "leagueplaceholder.png"))
            }
            
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamDetailsList?[0].players?.count ?? 0
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! TeamDetailsTableViewCell
        let currentPlayer = teamDetailsList?[0].players?[indexPath.row]
        cell.playerImage.kf.setImage(with: URL(string: currentPlayer?.player_image ?? ""), placeholder: UIImage(named: "leagueplaceholder.png"))
        cell.playerName.text = currentPlayer?.player_name
        //cell.playerName.text = "\(currentPlayer?.player_name ?? "") , \(currentPlayer?.player_type ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = tableView.frame.size.height / 4
        return cellHeight
    }
    

    

}
