//
//  FavouriteRecipe+CoreDataProperties.swift
//  cs4298_asg3
//
//  Created by Jeff chung on 25/11/2019.
//  Copyright © 2019 jacky yu. All rights reserved.
//
//

import Foundation
import CoreData


extension FavouriteRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteRecipe> {
        return NSFetchRequest<FavouriteRecipe>(entityName: "FavouriteRecipe")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: Int32
    @NSManaged public var title: String?

}
