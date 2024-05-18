//
//  HomeViewController.swift
//  SportsApp
//
//  Created by ahmed on 16/05/2024.
//

import UIKit
import Kingfisher
class HomeViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    var sports: [String] = ["Football", "Basketball", "Cricket", "Tennis"]
    var images: [String] = ["footballplayer.png", "basketballplayer.png","cricketplayer.png","tennisplayer.png"]
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
