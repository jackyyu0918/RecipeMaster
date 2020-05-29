//
//  HomePageVC.swift
//  cs4298_asg3
//
//  Created by Jeff chung on 17/11/2019.
//  Copyright © 2019 jacky yu. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITabBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var randomRecipeList:[Recipe] = []
    @IBOutlet weak var recipeCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
        return randomRecipeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionCell", for: indexPath) as! recipeCollectionCell
        
        if(self.randomRecipeList[indexPath.row].image != nil)
        {
            let url = URL(string: self.randomRecipeList[indexPath.row].image!)
            cell.imageView1.load(url: url!)
            cell.recipeTitle1.text = self.randomRecipeList[indexPath.row].title
            print("testing: \(self.randomRecipeList[indexPath.row].title)")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath){
        print("cell clicked \(indexPath.row)")
        
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "searchingDetail") as! SearchDetailVC
        let targetResult = randomRecipeList[indexPath.row]
        
        destinationVC.recipe = RecipeJson.getRecipeInfo(id: targetResult.id)
        
        destinationVC.summary = RecipeJson.getSummary(id: targetResult.id)
        self.navigationController!.pushViewController(destinationVC, animated: true)
    }
    
    
  override func viewDidLoad() {
    randomRecipeList = RecipeJson.getRandomRecipe(number: 10)
    super.viewDidLoad()
    
    recipeCollectionView.delegate = self
    recipeCollectionView.dataSource = self}
}
