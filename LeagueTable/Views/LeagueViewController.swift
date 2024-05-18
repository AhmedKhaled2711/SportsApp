//
//  LeagueViewController.swift
//  SportsApp
//
//  Created by ahmed on 17/05/2024.
//

import UIKit

class LeagueViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let cellID = "LeagueCell"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! LeagueTableViewCell
        cell.leagueImage.image = UIImage(named: "leagueplaceholder.png")
        cell.leagueTitle.text = "premier league"
        cell.youtubeLinkImage.image = UIImage(named: "youtubelogo3.png")
        // Configure the cell...

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = tableView.frame.size.height / 4
        return cellHeight
    }
    
    var leagueList : [LeagueItem]?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "League Table"
        tableView.delegate = self
        tableView.dataSource = self
        NetworkManager().fetchLeaguesData{[weak self] result in
            switch result {
            case .success(let leagueResponse):
                let leagueList = leagueResponse.result
                print(leagueList)
                self?.leagueList = leagueList
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
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
