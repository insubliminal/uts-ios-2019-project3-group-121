//
//  SearchViewController.swift
//  make my meal
//
//  Created by Insub Lim on 22/5/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTf: UITextField!
    
    var addedIngredients: [String] = []
    let dataStorage = DataRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBtn(_ sender: Any) {
        
        
        
//        searchedItems.removeAll()
//        searchedItems.append(searchTf.text!)
//        performSegue(withIdentifier: "toList", sender: self)
    }
    

    @IBAction func addIngredientBtn(_ sender: Any) {
        addedIngredients.append(searchTf.text!)
        try? dataStorage.saveIngredients(addedIngredients)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if segue.identifier == "toIngredientsList" {
//            let ingredientsTableViewController = segue.destination as! IngredientsTableViewController
//            
//            ingredientsTableViewController.addedIngredients = addedIngredients
//        }
        
    }
    
}
