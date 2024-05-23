//
//  LeagueDetailsCollectionViewController.swift
//  SportsApp
//
//  Created by Ahmed Khaled on 19/05/2024.
//

import UIKit
import Kingfisher

protocol SectionTitleProvider {
    func titleForSection(_ section: Int) -> String
}

class LeagueDetailsCollectionViewController: UICollectionViewController  , SectionTitleProvider{
    
    var leagueItem : LeagueItem?
    var sportNameRecieved : String?
    let leagueDetailsViewModel = LeagueDetailsViewModel(network: NetworkManager()) // Need to implement dependency incjection later
    var listOfUpcomingEvents : [UpcomingEvent]?
    var listOfLiveMatches : [LiveMatchResult]?
    var listOfTeams : [Team]?
    var isFavorite = false
    
    
    @IBAction func favoriteBtn(_ sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch sectionIndex {
            case 0:
                return self.upcomingEventsTop()
            case 1:
                return self.liveMatchesMiddle()
            default:
                return self.teamsBottom()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        // listOfUpcomingEvents
        if let leagueKey = self.leagueItem?.league_key {
            leagueDetailsViewModel.fetchUpcomingEvents(sportName : sportNameRecieved!.lowercased()  , leagueId: leagueKey)
            
            leagueDetailsViewModel.dataBinderUpcomingEvents = { [weak self] () in
                self?.listOfUpcomingEvents = self?.leagueDetailsViewModel.listOfUpcomingEvents
                //self?.loadingIndicator.stopAnimating()
                if let listOfEvents = self?.listOfUpcomingEvents {
                    print(listOfEvents[0].event_date ?? "")
                } else {
                    print("listOfUpcomingEvents is nil")
                }

                self?.collectionView.reloadData()
            }
            
        } else {
            print("Error in leagueItem or league_key is nil")
        }
        
        // listOfLiveMatches
        if let leagueKey = self.leagueItem?.league_key {
            leagueDetailsViewModel.fetchResults(sportName : sportNameRecieved!.lowercased()  , leagueId: leagueKey)
            
            leagueDetailsViewModel.dataBinderResults = { [weak self] () in
                self?.listOfLiveMatches = self?.leagueDetailsViewModel.listOfResults
                //self?.loadingIndicator.stopAnimating()
                if let listOfEvents = self?.listOfLiveMatches {
                    print(listOfEvents[0].event_final_result ?? "")
                } else {
                    print("listOfUpcomingEvents is nil")
                }

                self?.collectionView.reloadData()
            }
            
        } else {
            print("Error in leagueItem or league_key is nil")
        }
        
        // listOfTeams
        if let leagueKey = self.leagueItem?.league_key {
            leagueDetailsViewModel.fetchTeams(sportName : sportNameRecieved!.lowercased() , leagueId: leagueKey)
            
            leagueDetailsViewModel.dataBinderTeams = { [weak self] () in
                self?.listOfTeams = self?.leagueDetailsViewModel.listOfTeams
                //self?.loadingIndicator.stopAnimating()
                if let listOfEvents = self?.listOfTeams {
                    print(listOfEvents[0].team_name ?? "")
                } else {
                    print("listOfTeams is nil")
                }

                self?.collectionView.reloadData()
            }
            
        } else {
            print("Error in leagueItem or league_key is nil")
        }
    }
        
    func titleForSection(_ section: Int) -> String {
        switch section {
        case 0:
            return "Upcoming Events"
        case 1:
            return "Live Matches"
        case 2:
            return "Teams"
        default:
            return ""
        }
    }


    func upcomingEventsTop() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(225))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        section.orthogonalScrollingBehavior = .continuous

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]

        

//
//            section.visibleItemsInvalidationHandler = { items, offset, environment in
//                items.forEach { item in
//                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
//                    let minScale: CGFloat = 0.8
//                    let maxScale: CGFloat = 1.0
//                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
//                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
//                }
//            }
        
        return section
    }

    func teamsBottom() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        section.orthogonalScrollingBehavior = .continuous

        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }

    func liveMatchesMiddle() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           
           let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180))
           let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
           group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
           
           let section = NSCollectionLayoutSection(group: group)
           section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
           section.orthogonalScrollingBehavior = .none
           
           let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
           let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
           section.boundarySupplementaryItems = [header]
           
           return section
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
           case 0:
               return listOfUpcomingEvents?.count ?? 0 // Use the count of upcoming events
           case 1:
               // Return the count of live matches data
            return listOfLiveMatches?.count ?? 0
           case 2:
               // Return the count of teams data
            return listOfTeams?.count ?? 0
           default:
               return 0
           }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellIdentifier = ""
        
        switch indexPath.section {
        case 0:
                cellIdentifier = "upcomingEventsCell"
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! upcomingEventsCell
                if let event = listOfUpcomingEvents?[indexPath.item] {
                    
                    cell.date.text = event.event_date
                    cell.time.text = event.event_time
                    cell.homeTeamName.text = event.event_home_team
                    cell.awayTeamName.text = event.event_away_team
                    cell.homeTeamImage.kf.setImage(with: URL(string: event.home_team_logo ?? ""), placeholder: UIImage(named: "leagueplaceholder.png"))
                    cell.awayTeamImage.kf.setImage(with: URL(string: event.away_team_logo ?? ""), placeholder: UIImage(named: "leagueplaceholder.png"))
                }
                cellBorder(cell)
                return cell
        case 1:
            cellIdentifier = "liveMatchesCell"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! liveMatchesCell
            if let event = listOfLiveMatches?[indexPath.item] {
                
                cell.score.text = event.event_final_result
                cell.date.text = event.event_date
                cell.time.text = event.event_time
                cell.homeTeamName.text = event.event_home_team
                cell.awayTeamName.text = event.event_away_team
                cell.homeTeamImage.kf.setImage(with: URL(string: event.home_team_logo ?? ""), placeholder: UIImage(named: "leagueplaceholder.png"))
                cell.awayTeamImage.kf.setImage(with: URL(string: event.away_team_logo ?? ""), placeholder: UIImage(named: "leagueplaceholder.png"))
            }
            cellBorder(cell)
            return cell
        case 2:
            cellIdentifier = "TeamsCell"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TeamsCell
            if let event = listOfTeams?[indexPath.item] {
                
                cell.teamImage.kf.setImage(with: URL(string: event.team_logo ?? ""), placeholder: UIImage(named: "leagueplaceholder.png"))
            }
            cellBorder(cell)
            return cell
        default:
            print("error")
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
            header.titleLabel.text = titleForSection(indexPath.section)
            return header
        }
        return UICollectionReusableView()
    }
    
    func cellBorder(_ cell: UICollectionViewCell) {
            cell.contentView.backgroundColor = .white
            cell.contentView.layer.borderWidth = 0.5
            cell.contentView.layer.borderColor = UIColor.systemGray2.cgColor
            cell.contentView.layer.cornerRadius = 16
        }
    
    


}
