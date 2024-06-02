//
//  HomeViewController.swift
//  SportsApp
//
//  Created by ahmed on 16/05/2024.
//

import UIKit
import Kingfisher
import Reachability
class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    var sports: [String] = ["Football", "Basketball", "Cricket", "Tennis"]
    //var images: [String] = ["footballplayer.png", "basketballplayer.png", "cricketplayer.png", "tennisplayer.png"]
    var images: [String] = ["football", "basketball", "cricket", "tennis"]
    var reachability: Reachability!
    var isReachable: Bool = true

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let collectionViewSize = collectionView.frame.size.width - padding
        let collectionViewHeight = collectionView.frame.size.height - padding
        let cellHeight = collectionViewHeight / 2
        let cellWidth = collectionViewSize / 2
        return CGSize(width: cellWidth - padding, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCollectionViewCell
        cell.sportName.text = sports[indexPath.row]

        // Load image with placeholder
        let imageName = images[indexPath.row]
        cell.sportImage.image = UIImage(named: imageName)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard isReachable else {
            showAlertNoConnection()
            return
        }
        let leagueStoryBoard = UIStoryboard(name: "LeagueTable", bundle: nil)
        let leagueVC = leagueStoryBoard.instantiateInitialViewController() as! LeagueViewController
        leagueVC.modalPresentationStyle = .fullScreen
        leagueVC.sportName = sports[indexPath.row]
        navigationController?.pushViewController(leagueVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        setupReachability()
        startMonitoring()
    }

    deinit {
        stopMonitoring()
    }
}

extension HomeViewController {
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
