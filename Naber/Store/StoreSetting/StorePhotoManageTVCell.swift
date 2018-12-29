//
//  StorePhotoManageTVCell.swift
//  Naber
//
//  Created by 王淳彦 on 2018/12/29.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class StorePhotoManageTVCell: UITableViewCell {
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var photo: UIImageView! {
        didSet {
            self.photo.image = UIImage(named: "NaberBaseImage")
            self.photo.contentMode = .scaleAspectFill
            self.photo.autoresizingMask = UIViewAutoresizing.flexibleHeight
            self.photo.clipsToBounds = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
