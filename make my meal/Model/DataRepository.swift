//
//  DataRepository.swift
//  make my meal
//
//  Created by Gayun Kim on 2/6/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import Foundation
struct DataRepository: Codable {
    
    let favoriteRecipesURL: URL
    let ingredientsURL: URL
    
    enum DataError:Error {
        case notSaved
        case notFound
    }
    
    init()
    {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        favoriteRecipesURL = documentDirectory.appendingPathComponent("favorite_recipes").appendingPathExtension("json")
        ingredientsURL = documentDirectory.appendingPathComponent("ingredients").appendingPathExtension("json")
    }
    
    func saveFavoriteRecipes(_ favoriteRecipes: [Recipe]) throws
    {
        if let encodedFavoriteRecipes = try? JSONEncoder().encode(favoriteRecipes)
        {
            try? encodedFavoriteRecipes.write(to: favoriteRecipesURL, options: .noFileProtection)
        }
    }
    
    func loadFavoriteRecipes() throws -> [Recipe]
    {
        guard let encodedFavoriteRecipes = try? Data(contentsOf: favoriteRecipesURL) else {throw DataError.notFound}
        return try! JSONDecoder().decode([Recipe].self, from: encodedFavoriteRecipes)
    }
    
    func saveIngredients(_ ingredients: [String]) throws
    {
        if let encodedIngredients = try? JSONEncoder().encode(ingredients)
        {
            try? encodedIngredients.write(to: ingredientsURL, options: .noFileProtection)
        }
    }
    
    func loadIngredients() throws -> [String]
    {
        guard let encodedIngredients = try? Data(contentsOf: ingredientsURL) else {throw DataError.notFound}
        return try! JSONDecoder().decode([String].self, from: encodedIngredients)
    }
    
}
