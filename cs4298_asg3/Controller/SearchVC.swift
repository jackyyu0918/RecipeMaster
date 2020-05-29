//
//  SearchPageVC.swift
//  cs4298_asg3
//
//  Created by Jeff chung on 20/11/2019.
//  Copyright © 2019 jacky yu. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print ("1: \(nameTextView.text)")
        print("2: \(numberOfRecordTextView.text)")
    }
    
    
    @IBOutlet weak var nameTextView: UITextField!
    @IBOutlet weak var numberOfRecordTextView: UITextField!
    
    @IBAction func searchButton(_ sender: Any) {
        
        if nameTextView.text == "" || numberOfRecordTextView.text == "" {
            let controller = UIAlertController(title: "Failed!", message: "You must fill in the name and number.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
        }
        else {
            let results = RecipeJson.getBasicInfo(keyword: nameTextView.text!, number: Int(numberOfRecordTextView.text!) ?? 0)
            
            //change view controller
            if let controller = storyboard?.instantiateViewController(withIdentifier: "searchingResult") as? SearchResultVC{
                
                controller.result = results
                controller.keyword = nameTextView.text!
                navigationController?.pushViewController(controller, animated: true)
            }
        }
        
        
    }
}
