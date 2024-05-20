//
//  LeagueViewController.swift
//  SportsApp
//
//  Created by ahmed on 17/05/2024.
//

import UIKit
import Kingfisher
class LeagueViewController: UIViewController , UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    var sportName : String?
    let cellID = "LeagueCell"
    let leagueTableViewModel = LeagueTableViewModel(network: NetworkManager()) // Need to implement dependency incjection later
    var leagueList : [LeagueItem]?
    var filteredLeagueList : [LeagueItem]?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLeagueList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! LeagueTableViewCell
        let favoriteImageView = cell.youtubeLinkImage
        let currentLeague = filteredLeagueList?[indexPath.row]
//        print(currentLeague?.youtube)
        cell.leagueImage.kf.setImage(with: URL(string: currentLeague?.league_logo ?? ""), placeholder: UIImage(named: "leagueplaceholder.png"))
        cell.leagueTitle.text = currentLeague?.league_name
        cell.youtubeLinkImage.image = UIImage(named: "youtubelogo3.png")
        // Configure the cell...

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = tableView.frame.size.height / 4
        return cellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // write your code here
        
    }
    
    
    // search bar delegate methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            filteredLeagueList = leagueList
        }else{
            filteredLeagueList = leagueList?.filter{ league in
                return league.league_name?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
        self.tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredLeagueList = leagueList
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = sportName
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        leagueTableViewModel.fetchLeagueList(sportName: self.sportName!.lowercased())
//        print(DataBase().fetchFavoriteLeagues())
        leagueTableViewModel.dataBinder = { [weak self] () in
            self?.leagueList = self?.leagueTableViewModel.leagueList
            self?.filteredLeagueList = self?.leagueList
            self?.loadingIndicator.stopAnimating()
            self?.tableView.reloadData()
            
        }
        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
