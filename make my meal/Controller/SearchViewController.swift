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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addIngredientBtn(_ sender: Any) {
        addedIngredients.append(searchTf.text!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toIngredients" else {return}
        
        let ingredientsTableViewController = segue.destination as! IngredientsTableViewController
        ingredientsTableViewController.addedIngredients = addedIngredients
        print(addedIngredients)
    }
    
}
