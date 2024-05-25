//
//  SectionHeaderView.swift
//  SportsApp
//
//  Created by Ahmed Khaled on 20/05/2024.
//

import Foundation
import UIKit
class SectionHeaderView : UICollectionReusableView{
    static let reuseIdentifier = "SectionHeaderView"
        
        let titleLabel = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            titleLabel.textColor = .black
            
            addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
