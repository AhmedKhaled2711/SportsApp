//
//  LeagueTableViewCell.swift
//  SportsApp
//
//  Created by ahmed on 16/05/2024.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var youtubeLinkImage: UIImageView!
    @IBOutlet weak var leagueTitle: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    var favoriteImageTapped: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        youtubeLinkImage.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favoriteImageTappedAction))
        youtubeLinkImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func favoriteImageTappedAction() {
        favoriteImageTapped?()
    }

}
