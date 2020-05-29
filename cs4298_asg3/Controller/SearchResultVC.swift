//
//  SearchResultVC.swift
//  cs4298_asg3
//
//  Created by Jeff chung on 20/11/2019.
//  Copyright © 2019 jacky yu. All rights reserved.
//

import UIKit

class SearchResultVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var result:[Recipe]?
    var keyword:String = ""
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var numberLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if result?.count == 0 {
            let controller = UIAlertController(title: "Oh no!", message: "No recipe related to \"\(keyword)\" is found,\nplease try again.", preferredStyle: .alert)
                       let okAction = UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in self.navigationController?.popToRootViewController(animated: true)})
                       controller.addAction(okAction)
                       present(controller, animated: true, completion: nil)
        }
        
        numberLabel.text = String(result?.count ?? 0)
        self.resultTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as? ResultListViewCell else {
        return UITableViewCell()
        }
        
        cell.recipeName.text = result?[indexPath.row].title
        return cell
    }
    
    //onClick function
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell clicked \(indexPath.row)")
        
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "searchingDetail") as! SearchDetailVC
        let targetResult = result?[indexPath.row]
        
        destinationVC.recipe = RecipeJson.getRecipeInfo(id: targetResult!.id)
        
        destinationVC.summary = RecipeJson.getSummary(id: targetResult!.id)
        self.navigationController!.pushViewController(destinationVC, animated: true)
    }
}
