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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
