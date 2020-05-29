//
//  FavouriteVC.swift
//  cs4298_asg3
//
//  Created by Jeff chung on 20/11/2019.
//  Copyright © 2019 jacky yu. All rights reserved.
//

import UIKit

class FavouriteVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    static var isReminded:Bool = false
    var result:[FavouriteRecipe] = FavouriteRecipe.fetchRecored()

    @IBOutlet weak var favouriteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favouriteTableView.dataSource = self
        self.favouriteTableView.delegate = self
        
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
        result = FavouriteRecipe.fetchRecored()
            super.viewWillAppear(animated)
    print("update click")
            DispatchQueue.main.async{
                self.result = FavouriteRecipe.fetchRecored()
                self.favouriteTableView.reloadData()
                self.favouriteTableView.beginUpdates()
                self.favouriteTableView.endUpdates()
            }
        
        if FavouriteVC.isReminded == false{
            let controller = UIAlertController(title: "Hint", message: "Swap left to delete record!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
            
            FavouriteVC.isReminded = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! FavouriteListViewCell
        
        cell.titleName.text = result[indexPath.row].title
        cell.dateLabel.text = result[indexPath.row].getDateString()
        
        return cell
    }
    
    //onClick function
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell clicked \(indexPath.row)")
        
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "searchingDetail") as! SearchDetailVC
        let targetResult = result[indexPath.row]
        
        destinationVC.recipe = RecipeJson.getRecipeInfo(id: Int(targetResult.id))
        
        destinationVC.summary = RecipeJson.getSummary(id: Int(targetResult.id))
        self.navigationController!.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let currentRecordIndex: Int = indexPath.row
        if editingStyle == .delete {
            FavouriteRecipe.deleteRecord(record: result[currentRecordIndex])
            result.remove(at: currentRecordIndex)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
