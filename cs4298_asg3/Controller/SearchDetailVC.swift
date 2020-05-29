//
//  SearchDetailVC.swift
//  cs4298_asg3
//
//  Created by Jeff chung on 20/11/2019.
//  Copyright © 2019 jacky yu. All rights reserved.
//

import UIKit
import CoreData

class SearchDetailVC: UIViewController {
    
    var recipe:Recipe!
    var summary:String?
    static var isReminded:Bool = false
    
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var Description: UILabel!
    //@IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var addFavouriteButton: UIBarButtonItem!
    
    @IBAction func addFavouriteButtonOnClick(_ sender: UIBarButtonItem) {
        
        if FavouriteRecipe.isExist(id: recipe.id) == false {
            FavouriteRecipe.addRecord(id: recipe.id, title: recipe.title, date: Date() as NSDate)
           
            let controller = UIAlertController(title: "Success", message: "This recipe is added to your favourite list.", preferredStyle: .alert)
                       let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                       controller.addAction(okAction)
                       present(controller, animated: true, completion: nil)
        } else {
            let controller = UIAlertController(title: "Opps", message: "This recipe exists in your favourite list.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idLabel.text = String(recipe.id)
        titleLabel.text = recipe.title
        
        //URL image
        
        let url = URL(string: recipe.image!)
        recipeImageView.load(url: url!)
        
        minuteLabel.text = String(recipe.readyInMinutes!)
        servingsLabel.text = String(recipe.servings!)
        
        let newString = summary?.replacingOccurrences(of: "<b>", with: "")
        
        let newString1 = newString?.replacingOccurrences(of:  "</b>", with: "")
        
        Description.text = newString1
        
        if FavouriteVC.isReminded == false{
            let controller = UIAlertController(title: "Hint", message: "Click the star at top right side to add recipe!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
            
            FavouriteVC.isReminded = true
        }
        
        
    }
    
    @IBAction func extraButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let controller = storyboard?.instantiateViewController(identifier: "ingredientPage") as! IngredientVC
            
            controller.id = recipe.id
            controller.titleName = recipe.title
            self.navigationController?.pushViewController(controller, animated: true)
        case 1:
            let controller = storyboard?.instantiateViewController(identifier: "nutritionPage") as! NutritionVC
            
            controller.id = recipe.id
            controller.titleName = recipe.title
            self.navigationController?.pushViewController(controller, animated: true)
        default:
            break
        }
        
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
