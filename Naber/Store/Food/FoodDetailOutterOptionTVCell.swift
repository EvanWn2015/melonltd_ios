//
//  FoodDetailThreeTVCell.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/9.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

protocol OutterOptionDelegate: class {
    func addInnerCell(cell: FoodDetailOutterOptionTVCell)
}

class FoodDetailOutterOptionTVCell: UITableViewCell {
    
    weak var delegate: OutterOptionDelegate?
    
//    var innerOption = [FoodOption]()
    
    var outterTableIndex:Int = -1
    @IBOutlet weak var outterOptionName: DesignableTextField!
    
    @IBOutlet weak var outterDeleteButton: UIButton!
    
    @IBOutlet weak var innerOptionAdd: UIButton!
    
    @IBOutlet weak var demandChildTableView: UITableView! {
        didSet {
            self.demandChildTableView.delegate = self
            self.demandChildTableView.dataSource = self
        }
    }
    
    @IBOutlet weak var innerTableHiehgtConstraint: NSLayoutConstraint!
    
    @IBAction func addInnerOption(_ sender: Any) {
//        let option = FoodOption()
//        innerOption.append(option)
//        print("inner option count :",innerOption.count)
//        self.demandChildTableView.reloadData()
//        self.innerTableHiehgtConstraint.constant = CGFloat(innerOption.count * 40)
//        delegate?.addInnerCell(cell: self)
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        self.demandChildTableView.estimatedRowHeight = 40
        self.demandChildTableView.rowHeight = UITableViewAutomaticDimension
//        self.demandChildTableView.borderColor = UIColor.gray
//        self.demandChildTableView.borderWidth = 0.5

        self.innerTableHiehgtConstraint.constant = CGFloat( 40 )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
extension FoodDetailOutterOptionTVCell : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("innerOption",innerOption.count)
//        return innerOption.count
        return 0
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "InnerCell"

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodDetailInnerOptionTVCell

//        cell.name.text = innerOption[indexPath.row].name
//        cell.delete.tag = indexPath.row
//        cell.delete.addTarget(self, action: #selector(innerOptionDelete(sender:)), for: .touchUpInside)
//        cell.name.tag = indexPath.row
//        cell.name.addTarget(self, action:  #selector(innerOptionChange(sender:)), for: .editingDidEnd)
        return cell
    }
    
    @objc func innerOptionDelete(sender : UIButton!) {
//        innerOption.remove(at: sender.tag)
//        self.demandChildTableView.reloadData()
//        self.innerTableHiehgtConstraint.constant = CGFloat(innerOption.count * 40)
//        delegate?.addInnerCell(cell: self)
    }
    
    @objc func innerOptionChange(sender : UITextField!) {
//        print(sender.text!)
//        innerOption[sender.tag].name = sender.text!
//        self.demandChildTableView.reloadData()
//        delegate?.addInnerCell(cell: self)
    }
    
    
}
