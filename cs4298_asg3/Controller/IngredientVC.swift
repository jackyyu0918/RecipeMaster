//
//  IngredientVC.swift
//  cs4298_asg3
//
//  Created by Jeff chung on 22/11/2019.
//  Copyright © 2019 jacky yu. All rights reserved.
//

import UIKit
import WebKit

class IngredientVC: UIViewController {
    
    @IBOutlet weak var RecipeName: UILabel!
    //@IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var uiwebview: UIWebView!
    var id:Int?
    var titleName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            RecipeName.text = titleName
        uiwebview.loadHTMLString(Ingredient.getIngredientWeb(id: id!)!, baseURL: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

