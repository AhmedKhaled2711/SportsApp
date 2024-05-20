//
//  LeagueDetailsCollectionViewController.swift
//  SportsApp
//
//  Created by Ahmed Khaled on 19/05/2024.
//

import UIKit

protocol SectionTitleProvider {
    func titleForSection(_ section: Int) -> String
}

class LeagueDetailsCollectionViewController: UICollectionViewController  , SectionTitleProvider{
    
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
            return 10
        }

        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cellIdentifier = ""
            
            switch indexPath.section {
            case 0:
                cellIdentifier = "upcomingEventsCell"
            case 1:
                cellIdentifier = "liveMatchesCell"
            case 2:
                cellIdentifier = "TeamsCell"
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

}
