//
//  RestaurantOrderOptionsCell.swift
//  Naber
//
//  Created by 王淳彦 on 2019/1/1.
//  Copyright © 2019年 Melone.L.T.D. All rights reserved.
//

import UIKit

class RestaurantOrderOptionsCell: UITableViewCell {
    
    @IBOutlet weak var optionName: UILabel!
    @IBOutlet weak var optionBtn: UIButton!
    @IBOutlet weak var optionSelect: UITextField!
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
