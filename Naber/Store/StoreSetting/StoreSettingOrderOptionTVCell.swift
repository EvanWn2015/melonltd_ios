//
//  StoreSettingOrderOptionTVCell.swift
//  Naber
//
//  Created by 王淳彦 on 2018/12/30.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class StoreSettingOrderOptionTVCell: UITableViewCell {
    
    @IBOutlet weak var neme: UILabel!
    @IBOutlet weak var status: UISwitch!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
