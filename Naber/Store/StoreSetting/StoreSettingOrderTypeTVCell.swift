//
//  StoreSettingOrderTypeTVC.swift
//  Naber
//
//  Created by 王淳彦 on 2018/12/30.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class StoreSettingOrderTypeTVCell: UITableViewCell {
    
    @IBOutlet weak var status: UISwitch!
    @IBOutlet weak var peiceText: UITextField!{
        didSet{
            self.peiceText.isHidden = true
        }
    }
    @IBOutlet weak var peiceBtn: UIButton!{
        didSet{
            self.peiceBtn.isHidden = true
        }
    }
    @IBOutlet weak var tyoeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
