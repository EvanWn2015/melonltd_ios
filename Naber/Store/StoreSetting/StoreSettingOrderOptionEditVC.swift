//
//  StoreSettingOrderOptionEditVC.swift
//  Naber
//
//  Created by 王淳彦 on 2018/12/31.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class StoreSettingOrderOptionEditVC: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    
    var orderOption : RestaurantOrderOptionVo!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var addText: UITextField!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            let refreshControl: UIRefreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1.0)])
            refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged )
            refreshControl.tintColor = UIColor.clear
            self.tableView.addSubview(refreshControl)
        }
    }
    
    @objc func refresh(sender: UIRefreshControl){
        sender.endRefreshing()
        self.tableView.reloadData()
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addText.placeholder = "請輸入「" + self.orderOption.option_name + "」選項內容"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        print(self.orderOption)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //新增
    @IBAction func addAction (_ sender: UIButton){
        
        if (self.addText.text?.isEmpty)! {
            let alert = UIAlertController.init(title: "", message: "選項內容不可白！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "我知道了", style: .default))
            alert.popoverPresentationController?.sourceView = self.view
            alert.popoverPresentationController?.sourceRect = CGRect.init(x: self.view.bounds.width/2 ,y: self.view.bounds.height , width: 1.0, height: 1.0)
            self.present(alert, animated: true, completion: nil)
        }else {
            self.orderOption.options.append(self.addText.text!)
            self.update {
                self.addText.text = ""
                self.tableView.reloadData()
            }
        }
    }
    
    // 刪除
    @IBAction func deleteAction (_ sender: UIButton){
        let alert = UIAlertController.init(title: "", message: "您確認要此送單選項？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "確定", style: .default, handler: { _ in
            self.orderOption.options.remove(at: sender.tag)
            self.update {
                self.tableView.reloadData()
            }
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .destructive))
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect.init(x: self.view.bounds.width/2 ,y: self.view.bounds.height , width: 1.0, height: 1.0)
        self.present(alert, animated: true, completion: nil)
    }
    
    func update (complete: @escaping () -> ()){
        ApiManager.addSellerOrderOpts(req: self.orderOption, ui: self, onSuccess: { resp in
            self.orderOption = resp
            complete()
        }) { err_msg in
            print(err_msg)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderOption.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIIdentifier.CELL.rawValue, for: indexPath) as! StoreSettingOrderOptionTVCell
        cell.neme.text = self.orderOption.options[indexPath.row]
        cell.deleteBtn.tag = indexPath.row
        return cell
    }
}
