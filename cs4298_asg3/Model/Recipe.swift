//
//  Recipe.swift
//  cs4298_asg3
//
//  Created by Jeff chung on 20/11/2019.
//  Copyright © 2019 jacky yu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Recipe {
    var id: Int
    var title: String
    var image: String?
    var readyInMinutes: Int?
    var servings: Int?
    var summary:String?
    
    init(id: Int, title: String){
        self.id = id
        self.title = title
    }
    
    init(id: Int, title: String, image: String?, readyInMinutes: Int?
        , servings: Int?, summary: String?, instructions: String?){
        self.id = id
        self.title = title
        self.image = image
        self.readyInMinutes = readyInMinutes
        self.servings = servings
        self.summary = summary
    }
}
