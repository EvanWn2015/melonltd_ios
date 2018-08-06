//
//  FoodVC.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/8.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit


class FoodVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var categorys: [RestaurantCategoryRelVo] = []
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
        self.categorys.removeAll()
        self.tableView.reloadData()
        ApiManager.sellerCategoryList(ui: self, onSuccess: { categorys in
            self.categorys.append(contentsOf: categorys)
            self.tableView.reloadData()
        }) { err_msg in
            print(err_msg)
        }
    }
    
    @IBOutlet weak var categoryName: UITextField! {
        didSet {
            self.categoryName.leftViewMode = .always
            self.categoryName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        }
    }
    
    @IBOutlet weak var addCategoryBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
   override func viewWillAppear(_ animated: Bool) {
        self.loadData(refresh: true)
        self.categoryName.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: UIIdentifier.CELL.rawValue, for: indexPath) as! FoodTVCell
        
        let status: SwitchStatus = SwitchStatus.of(name: self.categorys[indexPath.row].status)
        cell.switchBtn.isOn = status.status()
        cell.deleteBtn.tag = indexPath.row
        cell.editBtn.tag = indexPath.row
        cell.switchBtn.tag = indexPath.row
        
        cell.name.text = self.categorys[indexPath.row].category_name

        return cell
    }
    
    @IBAction func addCategoryAction(_ sender: UIButton) {
        if self.categoryName.text == "" {
            
        }else {
            
        }
    }
    
    @IBAction func deleteCategoryAction(_ sender: UIButton) {
        let reqData: ReqData = ReqData()
        reqData.uuid = self.categorys[sender.tag].category_uuid
        ApiManager.sellerDeleteCategory(req: reqData, ui: self, onSuccess: {
            self.categorys.remove(at: sender.tag)
            self.tableView.reloadData()
        }) { err_msg in
            print(err_msg)
        }
    }
    
    @IBAction func editCategoryAction(_ sender: UIButton) {
        print(sender.tag)
    }

    @IBAction func changeCategoryAction(_ sender: UISwitch) {
        let status: SwitchStatus = SwitchStatus.of(name: self.categorys[sender.tag].status)
        
        if status.status() != sender.isOn {
            let reqData: ReqData = ReqData()
            reqData.uuid = self.categorys[sender.tag].category_uuid
            reqData.status = SwitchStatus.of(bool: sender.isOn)
            ApiManager.sellerChangeCategoryStatus(req: reqData, ui: self, onSuccess: {
                self.categorys[sender.tag].status = reqData.status
                self.tableView.reloadData()
            }) { err_msg in
                sender.isOn = status.status()
                self.tableView.reloadData()
            }
        }
    }
    
}



