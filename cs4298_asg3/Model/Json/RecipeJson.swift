//
//  RecipeJson.swift
//  cs4298_asg3
//
//  Created by Jeff chung on 20/11/2019.
//  Copyright © 2019 jacky yu. All rights reserved.
//

import Foundation
import UIKit

class RecipeJson{
    
    struct ResponseData:Codable {
        let number: Int
        let results: [RecipeResult]
    }

    struct RandomRecipe:Codable{
        let recipes: [RecipeResult]
    }
    
    struct RecipeResult:Codable {
        let id: Int
        let title: String
        let image: String?
        let readyInMinutes: Int?
        let servings: Int?
        let summary: String?
        let instructions:String?
    }
    
    static func getBasicInfo(keyword: String, number: Int) -> [Recipe]?{
        
        var RecipeReturn = [Recipe]()
        
        //Recipe Food API
        let headers = [
            "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
            "x-rapidapi-key": "14dadad992mshe01414f22b1e4f0p10b6f7jsn3e4d9e8fc7f4"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?query=\(keyword)&number=\(number)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        
        //group testing for delay
        let group = DispatchGroup()
        
        group.enter()
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data: Data!, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                //print(httpResponse)
            }
            
            //end of API
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let responseData = try decoder.decode(ResponseData.self, from: data)

                print("=================================")
                print("Recipe.number: \(responseData.results.count)")
                
                if responseData.results.count > 0 {
                    for i in (0...responseData.results.count-1){
                        let recipeInstance = Recipe(
                            id: responseData.results[i].id,
                            title: responseData.results[i].title)
                        
                        print("===========Record=============")
                        print("Result \(i):")
                        RecipeReturn.append(recipeInstance)
                        
                        print("RecipeReturn in loop: \(RecipeReturn)")
                    }
                }
                
                //first leave
                group.leave()
            }
                
            catch {
                print ("No record found")
                //second leave
                group.leave()
            }
        })
        
        dataTask.resume()
        
        //group wait
        group.wait()
        print("ready to return: \(RecipeReturn)")
        return RecipeReturn
    }
    
    static func getRecipeInfo(id: Int) -> Recipe?{
        
        var RecipeReturn:Recipe?
        
        //Recipe Food API
        let headers = [
            "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
            "x-rapidapi-key": "14dadad992mshe01414f22b1e4f0p10b6f7jsn3e4d9e8fc7f4"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/\(id)/information")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        
        //group testing for delay
        let group = DispatchGroup()
        
        group.enter()
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data: Data!, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
            }
            
            //end of API
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let responseData = try decoder.decode(RecipeResult.self, from: data)
                
                    
            let recipeInstance = Recipe(
                id: responseData.id,
                title: responseData.title,
                image: responseData.image,
                readyInMinutes: responseData.readyInMinutes,
                servings: responseData.servings, summary: nil, instructions: nil)
                        
                    RecipeReturn = recipeInstance
                    group.leave()
                }
                    
                catch {
                    print ("No record found")
                    group.leave()
                }
            })
                        
                dataTask.resume()
                        
                //group wait
                group.wait()
                return RecipeReturn
    }
    
    static func getSummary(id: Int) -> String?{
        
        var summaryString:String? = ""
        
        let headers = [
            "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
            "x-rapidapi-key": "14dadad992mshe01414f22b1e4f0p10b6f7jsn3e4d9e8fc7f4"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/\(id)/summary")! as URL,
            cachePolicy: .useProtocolCachePolicy,
        timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        
        //group testing for delay
        let group = DispatchGroup()
        
        group.enter()
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data: Data!, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
            }
            
            //end of API
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let responseData = try decoder.decode(RecipeResult.self, from: data)
                
            summaryString = responseData.summary
            group.leave()
        }
                    
        catch {
            print ("No record found")
            group.leave()
        }
    })
                        
        dataTask.resume()
                
        //group wait
        group.wait()
        return summaryString
    }
    
    static func getRandomRecipe(number: Int) -> [Recipe]{
        var recipeList:[Recipe] = []
        
        let headers = [
            "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
            "x-rapidapi-key": "14dadad992mshe01414f22b1e4f0p10b6f7jsn3e4d9e8fc7f4"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/random?number=\( number)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        
        let group = DispatchGroup()
        group.enter()
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data: Data!, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
            }
            
            do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let responseData = try decoder.decode(RandomRecipe.self, from: data)
                        
                for record in responseData.recipes{
                    
                    let recipeInstance = Recipe(
                        id: record.id,
                        title: record.title,
                        image: record.image,
                        readyInMinutes: record.readyInMinutes,
                        servings: record.servings, summary: nil, instructions: record.summary)
                    
                    print("================")
                    print("Appending: \(recipeInstance)")
                    print("Attirtube starting title: \(recipeInstance.title)")
                    recipeList.append(recipeInstance)
                }
                            
                            group.leave()
                        }
                            
                        catch {
                            print ("No record found")
                            group.leave()
                        }
                    })
                                
                        dataTask.resume()
                                
                        //group wait
                        group.wait()
                        return recipeList
            }
}
