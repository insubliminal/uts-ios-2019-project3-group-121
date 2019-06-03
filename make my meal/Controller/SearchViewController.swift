//
//  SearchViewController.swift
//  make my meal
//
//  Created by Insub Lim on 22/5/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var addedIngredients: [String] = []
    
    @IBOutlet weak var searchTf: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        addedIngredients.removeAll()
    }
    
    @IBAction func addIngredientBtn(_ sender: Any) {
        addedIngredients.append(searchTf.text!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toIngredients" else {return}
        
        let ingredientsTableViewController = segue.destination as! IngredientsTableViewController
        
        ingredientsTableViewController.addedIngredients = addedIngredients
    }
}
