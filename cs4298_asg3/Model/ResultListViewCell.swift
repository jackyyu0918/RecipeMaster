//
//  RecipeTableViewCell.swift
//  cs4298_asg3
//
//  Created by Jeff chung on 20/11/2019.
//  Copyright © 2019 jacky yu. All rights reserved.
//

import UIKit

class ResultListViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
