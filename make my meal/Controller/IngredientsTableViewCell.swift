//
//  IngredientsTableViewCell.swift
//  make my meal
//
//  Created by Gayun Kim on 3/6/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ingredientCell: UILabel!
    
    func update(with ingredient: String) {
        ingredientCell.text = ingredient
    }
    
}
