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
    
    var searchedItems: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBtn(_ sender: Any) {
        
        searchedItems.removeAll()
        searchedItems.append(searchTf.text!)
        performSegue(withIdentifier: "toList", sender: self)
    }
    
    @IBAction func testBtn(_ sender: Any) {
        searchedItems.removeAll()
        searchedItems.append(searchTf.text!)
        performSegue(withIdentifier: "toIngredients", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toList") {
            
            let list = segue.destination as! MatchingRecipeListTableViewController
            
            list.searchedItems = self.searchedItems
        }
        
        if (segue.identifier == "toIngredients") {
            
            let list = segue.destination as! IngredientsViewController
            
            list.searchedItems = self.searchedItems
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
