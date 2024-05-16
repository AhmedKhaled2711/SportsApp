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
    var sports: [String] = ["Soccer", "Basketball", "Hockey", "Tennis"]
    var images: [String] = ["footballplayer.png", "basketballplayer.png","cricketplayer.png","tennisplayer.png"]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let collectionViewSize = collectionView.frame.size.width - padding
        let cellWidth = collectionViewSize / 2
        return CGSize(width: cellWidth - padding, height: cellWidth - padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCollectionViewCell
        cell.sportName.text = sports[indexPath.row]
        // Load image with placeholder and error handling
//        cell.sportImage.kf.setImage(with: URL(string: ""),placeholder: UIImage(named: images[indexPath.row]))
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
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
