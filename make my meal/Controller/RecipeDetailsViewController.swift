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
    var recipeFromFavoriteList: String?
    
    
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var heartFilledBtn: UIButton!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let recipe = recipeFromList else{return}
        recipeNameLabel.text = recipe.name
        recipeImageView.image = UIImage(named: recipe.name)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteRecipe")
        request.returnsObjectsAsFaults = false
        
        guard let results = try? context.fetch(request) else {return}
        for result in results as! [NSManagedObject] {
            if let favoriterecipe = result.value(forKey: "name") as? String {
                if recipeFromList?.name == favoriterecipe {
                    heartBtn.isHidden = true
                    heartFilledBtn.isHidden = false
                    
                }
            }
        }
    }
    
    @IBAction func heartBtnPressed(_ sender: Any) {
        heartBtn.isHidden = true
        heartFilledBtn.isHidden = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let favoriteRecipe = NSEntityDescription.insertNewObject(forEntityName: "FavoriteRecipe", into: context)
        favoriteRecipe.setValue(recipeFromList?.name, forKey: "name")
        
        try? context.save()
        print("Saved")
        
    }
    
    @IBAction func heartFilledBtnPressed(_ sender: Any) {
        heartFilledBtn.isHidden = true
        heartBtn.isHidden = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteRecipe")
        request.returnsObjectsAsFaults = false
        
        guard let results = try? context.fetch(request) else {return}
        for result in results as! [NSManagedObject] {
            if let favoriteRecipeToRemove = result.value(forKey: "name") as? String {
                if recipeFromList?.name == favoriteRecipeToRemove {
                    context.delete(result)
                }
            }
        }
        try? context.save()
    }
    
}

