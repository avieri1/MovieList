//
//  HomeCell.swift
//  MovieList
//
//  Created by aldo on 15/02/24.
//

import UIKit

class HomeCell: UITableViewCell {
    
    static let identifier = String(describing: HomeCell.self)

    @IBOutlet weak var labelTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
