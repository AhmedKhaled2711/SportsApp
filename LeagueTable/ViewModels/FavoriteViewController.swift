//
//  FavoriteViewController.swift
//  SportsApp
//
//  Created by ahmed on 21/05/2024.
//

import UIKit
import Reachability
class FavoriteViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let cellID = "FavoriteCell"
    var favoriteList : [LeagueItem]?
    var filteredList : [LeagueItem]?
    var viewModel : FavoriteViewModel?
    var reachability: Reachability!
    var isReachable: Bool = true
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
            let deletedLeague = filteredList?[indexPath.row]
            let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to remove this league from favorites?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { _ in
                self.performDeleteAction(for: deletedLeague, at: indexPath)
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard isReachable else {
            showAlertNoConnection()
            return
        }
        print("Item selected at indexPath: \(indexPath)")

        if let selectedLeague = filteredList?[indexPath.row] {
            
            let storyboard = UIStoryboard(name: "LeagueDetails", bundle: nil)
            if let LeagueDetailsCollectionView = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsId") as? LeagueDetailsCollectionViewController {
                LeagueDetailsCollectionView.leagueItem = selectedLeague
                LeagueDetailsCollectionView.sportNameRecieved = selectedLeague.sportName
                //print(title)
                //print(selectedLeague.league_key ?? <#default value#>)
                LeagueDetailsCollectionView.modalPresentationStyle = .fullScreen
               // present(LeagueDetailsCollectionView, animated: true, completion: nil)
                navigationController?.pushViewController(LeagueDetailsCollectionView, animated: true)
            }
        }
    }

    func performDeleteAction(for league: LeagueItem?, at indexPath: IndexPath) {
        viewModel?.deleteLeagueFromFavorite(league: league)
        filteredList?.remove(at: indexPath.row)
        favoriteList?.removeAll { $0.league_name == league?.league_name }
        tableView.deleteRows(at: [indexPath], with: .automatic)
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
        title = "Favorite Leagues"
        loadingIndicator.stopAnimating()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        viewModel = FavoriteViewModel(dataBase: DataBase())
        setupReachability()
        startMonitoring()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favoriteList = DataBase().fetchFavoriteLeagues()
        filteredList = favoriteList
        tableView.reloadData()
    }
    deinit {
        stopMonitoring()
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
extension FavoriteViewController {
    func setupReachability() {
        do {
            reachability = try Reachability()
        } catch {
            print("Unable to create Reachability")
            return
        }

        reachability.whenReachable = { [weak self] reachability in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Add delay to debounce
                self?.isReachable = true
                print("Reachable via \(reachability.connection.description)")
            }
        }

        reachability.whenUnreachable = { [weak self] _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Add delay to debounce
                self?.isReachable = false
                print("Not reachable")
            }
        }
    }

    func startMonitoring() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    func stopMonitoring() {
        reachability.stopNotifier()
    }

    func showAlertNoConnection() {
        let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
