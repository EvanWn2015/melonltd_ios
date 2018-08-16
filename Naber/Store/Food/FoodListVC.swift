//
//  FoodClassVC.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/9.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class FoodListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var categoryRel: CategoryRelVo!
    var foods: [FoodVo] = []

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            let refreshControl: UIRefreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1.0)])
            refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
            refreshControl.tintColor = UIColor.clear
            self.tableView.addSubview(refreshControl)
        }
    }

    @objc func refresh(sender: UIRefreshControl){
        sender.endRefreshing()
        self.loadData(refresh: true)
    }
    
    func loadData(refresh: Bool){
        self.foods.removeAll()
        let reqData: ReqData = ReqData()
        reqData.uuid = self.categoryRel.category_uuid
        ApiManager.sellerFoodList(req: reqData, ui: self, onSuccess: { foods in
            print(foods)
            self.foods.append(contentsOf: foods)
            self.tableView.reloadData()
        }) { err_msg in
            print(err_msg)
        }
    }
    
    @IBOutlet weak var addFoodBtn: UIButton!
    @IBOutlet weak var name: UILabel!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData(refresh: true)
        self.name.text = self.categoryRel.category_name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIIdentifier.CELL.rawValue, for: indexPath) as! FoodTVCell
        
        cell.switchBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        cell.editBtn.tag = indexPath.row
        
        cell.name.text = self.foods[indexPath.row].food_name
        cell.price.text = "$ " + self.foods[indexPath.row].default_price
        let status: SwitchStatus = SwitchStatus.of(name: self.foods[indexPath.row].status)
        cell.switchBtn.isOn = status.status()
        
//        cell.photo.image = UIImage(named: "Logo")
        if self.foods[indexPath.row].photo != nil {
            cell.photo.setImage(with: URL(string: self.foods[indexPath.row].photo), transformer: TransformerHelper.transformer(identifier: self.foods[indexPath.row].photo))
        }else{
            cell.photo.image = UIImage(named: "Logo")
        }
        return cell
    }
    
    @IBAction func addFoodAction(_ sender: UIButton) {
        var foodName: UITextField!
        var defaultPrice: UITextField!
        let alert = UIAlertController( title: "", message: "請先輸入品項名稱與價格，\n在進行品項內容的編輯。", preferredStyle: .alert)
        alert.addTextField{ textField in
            textField.placeholder = "請輸入品項名稱"
            textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 36))
            textField.font?.withSize(30)
            foodName = textField
        }
        
        alert.addTextField{ textField in
            textField.placeholder = "請輸入價格"
            textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 36))
            textField.delegate = self
            textField.keyboardType = .numberPad
            textField.font?.withSize(30)
            defaultPrice = textField
        }
        alert.addAction(UIAlertAction(title: "取消", style: .destructive, handler:nil))
        alert.addAction(UIAlertAction(title: "確定新增", style: .default, handler: { _ in
            self.addFoodHandler(name: foodName.text!, price: defaultPrice.text!)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addFoodHandler (name: String, price: String) {
        if name == "" || price == "" || Int(price) == nil || Int(price)! <= 0 {
            let alert = UIAlertController( title: "NABER 提醒，新增品項失敗", message: "請注意品項名稱與價格不可空白，\n且價格不可為0!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "我知道了", style: .default))
            self.present(alert, animated: true, completion: nil)
        }else {

            let food: FoodVo = FoodVo()
            food.category_uuid = self.categoryRel.category_uuid
            food.food_name = StringsHelper.replace(str: name, of: " ", with: "")
            food.default_price = (price as NSString).integerValue.description
            food.food_data = FoodItemVo()
            let item: ItemVo = ItemVo.init(name: "統一規格", price: (price as NSString).integerValue.description, tag: 0)
            food.food_data.scopes.append(item)
            ApiManager.sellerFoodAdd(req: food, ui: self, onSuccess: { food in
                print(food)
                if let vc = UIStoryboard(name: UIIdentifier.STORE.rawValue, bundle: nil).instantiateViewController(withIdentifier: "FoodEdit") as? FoodEditVC {
                    vc.food = food
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }) { err_msg in
                print(err_msg)
            }
        }
    }
    
    @IBAction func editFoodAction(_ sender: UIButton) {
        if let vc = UIStoryboard(name: UIIdentifier.STORE.rawValue, bundle: nil).instantiateViewController(withIdentifier: "FoodEdit") as? FoodEditVC {
            vc.food = self.foods[sender.tag]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func deleteFoodAction(_ sender: UIButton) {
        let alert = UIAlertController( title: Optional.none, message: "刪除後將無法找回，\n您確定要刪除嗎？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .destructive, handler:nil))
        alert.addAction(UIAlertAction(title: "確定刪除", style: .default, handler: { _ in
            let reqData: ReqData = ReqData()
            reqData.uuid = self.foods[sender.tag].food_uuid
            ApiManager.sellerFoodDelete(req: reqData, ui: self, onSuccess: {
                self.foods.remove(at: sender.tag)
                self.tableView.reloadData()
            }) { err_msg in
                self.tableView.reloadData()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func changeFoodAction(_ sender: UISwitch) {
        let status: SwitchStatus = SwitchStatus.of(name: self.foods[sender.tag].status)
        if status.status() != sender.isOn {
            let reqData: FoodVo = self.foods[sender.tag]
            reqData.status = SwitchStatus.of(bool: sender.isOn)
            ApiManager.sellerFoodUpdate(req: reqData, ui: self, onSuccess: {
                self.foods[sender.tag].status = reqData.status
                self.tableView.reloadData()
            }) { err_msg in
                sender.isOn = status.status()
                self.tableView.reloadData()
            }
        }
    }
    
    // 限制輸入長度
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength: Int = text.count + string.count - range.length
        if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)) {
            return false
        }else if newLength == 1 && string == "0" {
            return false
        }else {
            return true
        }
    }

}


