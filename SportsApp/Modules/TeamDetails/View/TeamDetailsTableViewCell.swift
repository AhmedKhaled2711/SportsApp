//
//  TeamDetailsTableViewCell.swift
//  SportsApp
//
//  Created by Ahmed Khaled on 25/05/2024.
//

import UIKit

class TeamDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var playerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
