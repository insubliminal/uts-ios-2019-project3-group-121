//
//  FavoriteRecipeTableViewCell.swift
//  make my meal
//
//  Created by Gayun Kim on 28/5/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class FavoriteRecipeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var favoriteRecipeImage: UIImageView!
    @IBOutlet weak var favoriteRecipeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
