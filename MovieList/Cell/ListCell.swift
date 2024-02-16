//
//  ListCell.swift
//  MovieList
//
//  Created by aldo on 15/02/24.
//

import UIKit

class ListCell: UITableViewCell {

    static let identifier = String(describing: ListCell.self)
    
    @IBOutlet weak var primaryLbl: UILabel!
    
    @IBOutlet weak var secondaryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
