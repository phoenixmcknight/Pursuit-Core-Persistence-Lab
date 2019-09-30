//
//  FavoriteTableViewCell.swift
//  persistenceLab
//
//  Created by Phoenix McKnight on 9/30/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteImage: UIImageView!
    
    @IBOutlet weak var favoriteFavorites: UILabel!
    
    @IBOutlet weak var favoriteTags: UILabel!
    @IBOutlet weak var favoriteLikeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
