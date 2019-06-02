//
//  IngredientsViewController.swift
//  make my meal
//
//  Created by Insub Lim on 2/6/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class IngredientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var searchedItems: [String] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath)
        
        let ingredient = searchedItems[indexPath.row]
        
        cell.textLabel?.text = ingredient
        
        return cell
    }

    @IBAction func toRecipes(_ sender: Any) {
        
        performSegue(withIdentifier: "toList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toList") {
            
            let list = segue.destination as! MatchingRecipeListTableViewController
            
            list.searchedItems = self.searchedItems
        }
    }
}
