//
//  FavoriteRecipeTableViewCell.swift
//  make my meal
//
//  Created by Gayun Kim on 30/5/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class FavoriteRecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    
    func update(with recipe: String) {
        recipeImageView.image = UIImage(named: recipe)
        recipeName.text = recipe
    }
}
