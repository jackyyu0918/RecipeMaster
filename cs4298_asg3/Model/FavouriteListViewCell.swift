//
//  FavouriteListViewCell.swift
//  cs4298_asg3
//
//  Created by Jeff chung on 23/11/2019.
//  Copyright © 2019 jacky yu. All rights reserved.
//

import UIKit

class FavouriteListViewCell: UITableViewCell {
    
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
