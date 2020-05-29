//
//  FavouriteRecipe+CoreDataClass.swift
//  cs4298_asg3
//
//  Created by Jeff chung on 25/11/2019.
//  Copyright © 2019 jacky yu. All rights reserved.
//
//

import Foundation
import CoreData

@objc(FavouriteRecipe)
public class FavouriteRecipe: NSManagedObject {
        static func addRecord(id: Int, title: String, date: NSDate){
               
            let record:FavouriteRecipe = FavouriteRecipe(context: DbService.context)
               
            record.id = Int32(id)
            record.title = title
            record.date = date as Date
               
            DbService.saveContext()
            print("Added Record")
           }
           
           static func getCount() -> Int{
               let records = FavouriteRecipe.fetchRecored()
               return records.count
           }
           
           static func deleteRecord(record: FavouriteRecipe){
               print("-------------------------")
               print("Before delete: ", FavouriteRecipe.getCount())
               
               DbService.context.delete(record)
               DbService.saveContext()
               
               print("After delete: ", FavouriteRecipe.getCount())
               print("=========================")
           }
           
           static func fetchRecored() -> [FavouriteRecipe]{
               var request: NSFetchRequest<FavouriteRecipe> = FavouriteRecipe.fetchRequest()
               request.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: false)]
            request.returnsObjectsAsFaults = false
               var results: [FavouriteRecipe] = []
               
               do {
                   results = try DbService.context.fetch(request)
                   print(results.count)
               } catch  {
               }
               return results
           }
           
           
           
           func getTitleString() -> String{
               return self.title!
           }
           
           func getID() -> Int{
               return Int(self.id)
           }

           func getDateString() -> String{
               let formatter = DateFormatter()
               formatter.dateFormat = "yyyy-MM-dd"
               let dateString = formatter.string(from: self.date! as Date)
               return dateString
           }
        
        static func isExist(id: Int) -> Bool{
            let records = FavouriteRecipe.fetchRecored()
                   
                   for record in records{
                       if id == record.id{
                           return true
                       }
                   }
            
            return false
        }
}
