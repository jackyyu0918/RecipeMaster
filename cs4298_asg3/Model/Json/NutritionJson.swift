//
//  Nutrition.swift
//  cs4298_asg3
//
//  Created by Jeff chung on 20/11/2019.
//  Copyright © 2019 jacky yu. All rights reserved.
//

import Foundation

class Nutrition{
    static func getNutritionInfo(id: Int) -> String?{
        var htmlString:String?
        
        let headers = [
            "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
            "x-rapidapi-key": "14dadad992mshe01414f22b1e4f0p10b6f7jsn3e4d9e8fc7f4",
            "accept": "text/html"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/\(id)/nutritionWidget?defaultCss=true")! as URL,
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
                print(httpResponse)
            }
            
            do {
                guard let loadedData = data else {return}
                
                let contents = String(data: loadedData, encoding: .utf8)
                print("contents: \(contents)")
                htmlString = contents
                group.leave()
            }
        })

        
        dataTask.resume()
        group.wait()
        return htmlString
        
    }
}
