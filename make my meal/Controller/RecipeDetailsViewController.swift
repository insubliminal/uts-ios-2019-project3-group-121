//
//  RecipeDetailsViewController.swift
//  make my meal
//
//  Created by Gayun Kim on 30/5/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit
import CoreData

class RecipeDetailsViewController: UIViewController {
    
    var recipeFromList: Recipe?
    var favoriteRecipes: [Recipe] = []
    
    let DataStorage = DataRepository()
    
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var heartFilledBtn: UIButton!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeDescription: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let favoriteList = try? DataStorage.loadFavoriteRecipes() {
            favoriteRecipes = favoriteList
        }
        
        guard let recipe = recipeFromList else{return}
        
        recipeNameLabel.text = recipe.name
        recipeImageView.image = UIImage(named: recipe.name)
        recipeDescription.text = recipe.description
        timeLabel.text = recipe.time 
        
        for recipe in favoriteRecipes {
            guard let recipeFromList = recipeFromList else {return}
            
            if recipe == recipeFromList {
                heartBtn.isHidden = true
                heartFilledBtn.isHidden = false
            }
        }
    }
    
    @IBAction func heartBtnPressed(_ sender: Any) {
        heartBtn.isHidden = true
        heartFilledBtn.isHidden = false
        
        guard let recipe = recipeFromList else {return}
        
        favoriteRecipes.append(recipe)
        try? DataStorage.saveFavoriteRecipes(favoriteRecipes)
    }
    
    @IBAction func heartFilledBtnPressed(_ sender: Any) {
        heartFilledBtn.isHidden = true
        heartBtn.isHidden = false
        favoriteRecipes.removeLast()
        try? DataStorage.saveFavoriteRecipes(favoriteRecipes)
    }
}

