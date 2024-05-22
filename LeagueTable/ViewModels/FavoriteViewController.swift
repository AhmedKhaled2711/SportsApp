//
//  FavoriteViewController.swift
//  SportsApp
//
//  Created by ahmed on 21/05/2024.
//

import UIKit

class FavoriteViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let cellID = "FavoriteCell"
    var favoriteList : [LeagueItem]?
    var filteredList : [LeagueItem]?
    var viewModel : FavoriteViewModel?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! LeagueTableViewCell
        let league = filteredList?[indexPath.row]
//        print(currentLeague?.youtube)
        cell.leagueImage.kf.setImage(with: URL(string: league?.league_logo ?? ""), placeholder: UIImage(named: "leagueplaceholder.png"))
        cell.leagueTitle.text = league?.league_name
        cell.youtubeLinkImage.image = UIImage(named: "youtubelogo3.png")
        // Configure the cell...

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = tableView.frame.size.height / 4
        return cellHeight
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Update data source
            let deletedLeague = filteredList?[indexPath.row]
            viewModel?.deleteLeagueFromFavorite(league: deletedLeague)
            filteredList?.remove(at: indexPath.row)
            favoriteList?.removeAll(where: { league in
                league.league_name == deletedLeague?.league_name
            })
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    // search delegate methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            filteredList = favoriteList
        }else{
            filteredList = favoriteList?.filter{ league in
                return league.league_name?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.stopAnimating()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        viewModel = FavoriteViewModel(dataBase: DataBase())
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        favoriteList = DataBase().fetchFavoriteLeagues()
        filteredList = favoriteList
        tableView.reloadData()
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
