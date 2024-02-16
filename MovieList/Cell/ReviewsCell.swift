//
//  ReviewsCell.swift
//  MovieList
//
//  Created by aldo on 16/02/24.
//

import UIKit

class ReviewsCell: UICollectionViewCell {

    static let identifier = String(describing: ReviewsCell.self)
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var secondLbl: UILabel!
    
    @IBOutlet weak var thirdLbl: UILabel!
    
    @IBOutlet weak var contentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconView.layer.cornerRadius = iconView.frame.width / 2
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
    }
    

}
