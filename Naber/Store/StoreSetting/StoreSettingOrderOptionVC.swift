
//
//  StoreSettingOrderSelectVC.swift
//  Naber
//
//  Created by 王淳彦 on 2018/12/30.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class StoreSettingOrderOptionVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    
    
    var orderSendPrice: String = "0"
    var newOptionName: String = ""
    
    
    var orderOptionVos : [RestaurantOrderOptionVo] = []
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
        self.loadData(refresh: true)
    }
    
    func loadData(refresh: Bool){
        if (refresh){
            self.orderOptionVos.removeAll()
            self.tableView.reloadData()
        }
        ApiManager.getSellerOrderOpts(ui: self, onSuccess: { orderOptionVos in
            self.orderOptionVos.append(contentsOf: orderOptionVos)
            self.tableView.reloadData()
        }) { err_msg in
            print(err_msg)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData(refresh: true)
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.RESTAURANT_UUD = (UserSstorage.getAccountInfo()?.restaurant_uuid)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // 設定外送價格
    @IBAction func editSendPriceAction (_ sender: UIButton){
        var defaultPrice: UITextField!
      
        let alert = UIAlertController( title: "", message: "請輸入訂單滿額外送金額。", preferredStyle: .alert)

        alert.addTextField{ textField in
            textField.placeholder = "請輸入金額"
            textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 36))
            textField.delegate = self
            textField.keyboardType = .numberPad
            textField.font?.withSize(30)
            defaultPrice = textField
            defaultPrice.text = "0"
        }
        
        alert.addAction(UIAlertAction(title: "取消", style: .destructive, handler:nil))
        alert.addAction(UIAlertAction(title: "確定", style: .default, handler: { _ in
            self.orderSendPrice = defaultPrice.text!
            self.tableView.reloadRows(at: [IndexPath(item: 2, section: 0)], with: .automatic)
            // TODO Api update order type send price
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //訂單類型開關
    @IBAction func orderTypeStatusAction (_ sender: UISwitch){
        print("")
    }
    
    
    // 新增送單需求 Input
    @objc func addOptionInput(_ sender: UITextField){
        self.newOptionName = sender.text!
    }
    
    // 新增送單需求 Button
    @objc func addOptionBtn(_ sender: UIButton){
        
        if self.newOptionName.isEmpty {
            let alert = UIAlertController.init(title: "", message: "選項名稱不可白！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "我知道了", style: .default))
            alert.popoverPresentationController?.sourceView = self.view
            alert.popoverPresentationController?.sourceRect = CGRect.init(x: self.view.bounds.width/2 ,y: self.view.bounds.height , width: 1.0, height: 1.0)
            self.present(alert, animated: true, completion: nil)
        }else {
            let req: RestaurantOrderOptionVo = RestaurantOrderOptionVo()
            req.option_name = self.newOptionName
            ApiManager.addSellerOrderOpts(req: req, ui: self, onSuccess: { orderOption in
                print(orderOption)
                self.orderOptionVos.append(orderOption)
                self.newOptionName = ""
                self.tableView.reloadSections([1], with: .none)
            }) { err_msg in
                print(err_msg)
            }
        }
    }
    
    //訂單選項開關
    @IBAction func orderOptionStatusAction (_ sender: UISwitch){
        let status: SwitchStatus = SwitchStatus.of(name: self.orderOptionVos[sender.tag].status)
        if status.status() != sender.isOn {
            let req: ReqData = ReqData()
            req.id = self.orderOptionVos[sender.tag].id
            req.status = SwitchStatus.of(bool: sender.isOn)
            ApiManager.statusSellerOrderOpts(req: req, ui: self, onSuccess: { resp in
                self.orderOptionVos[sender.tag].status = req.status
                self.tableView.reloadSections([1], with: .none)
            }) { err_msg in
                sender.isOn = status.status()
                self.tableView.reloadSections([1], with: .none)
            }
        }
    }
    
    //訂單選項編輯
    @IBAction func orderOptionEditAction (_ sender: UIButton){
        print("")
        if let vc = UIStoryboard(name: UIIdentifier.STORE.rawValue, bundle: nil).instantiateViewController(withIdentifier: "StoreSettingOrderOptionEdit") as? StoreSettingOrderOptionEditVC {
            vc.orderOption = self.orderOptionVos[sender.tag]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //訂單選項刪除
    @IBAction func orderOptionDeleteAction (_ sender: UIButton){
        let alert = UIAlertController.init(title: "", message: "您確認要此送單選項？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "確定", style: .default, handler: { _ in
            let req: ReqData = ReqData()
            req.id = self.orderOptionVos[sender.tag].id
            ApiManager.deleteSellerOrderOpts(req: req, ui: self, onSuccess: { resp in
                self.orderOptionVos.remove(at: sender.tag)
                self.tableView.reloadSections([1], with: .none)
            }) { err_msg in
                print(err_msg)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "取消", style: .destructive))
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect.init(x: self.view.bounds.width/2 ,y: self.view.bounds.height , width: 1.0, height: 1.0)
        self.present(alert, animated: true, completion: nil)

    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.0 : 46.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame:CGRect = tableView.frame
        let headerView: UIView = UIView.init(frame: CGRect.init(x:0, y:0, width:frame.size.width, height:frame.size.height))
        
        switch section {
        case 0:
            let title: UILabel = UILabel.init(frame: CGRect.init(x:8, y:8, width:frame.size.width-84, height:30))
            title.text = "滿額金額"
            headerView.addSubview(title)
            break
        case 1:
            let add : UIButton = UIButton(type: .system)
            add.frame = CGRect.init(x:frame.size.width-68, y:8, width:60, height:30)
            add.tag = section
            add.setTitle("新增", for: .normal)
            add.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
            add.setTitleColor(.black, for: .normal)
            
            add.addTarget(self, action: #selector(addOptionBtn(_:)), for: .touchUpInside)
            
            let addText: UITextField = UITextField.init(frame: CGRect.init(x:8, y:8, width:frame.size.width-84, height:30))
            addText.borderStyle = .roundedRect
            addText.font = UIFont.systemFont(ofSize: 14.0)
            addText.tintColor = .blue
            addText.placeholder = "請輸入訂單選項名稱"
            addText.addTarget(self, action: #selector(addOptionInput(_:)), for: .editingChanged)
            addText.text = self.newOptionName
            
            headerView.addSubview(addText)
            headerView.addSubview(add)
            break
        default:
            break
            
        }
        
        headerView.backgroundColor = UIColor.white
        
        return headerView;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : self.orderOptionVos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: UIIdentifier.CELL.rawValue, for: indexPath) as! StoreSettingOrderTypeTVCell
            switch indexPath.row {
            case 0:
                cell.tyoeName.text = "外帶"
                break
            case 1:
                cell.tyoeName.text = "內用"
                break
            case 2:
                cell.tyoeName.text = "外送"
                cell.peiceText.text = self.orderSendPrice
                cell.peiceBtn.isHidden = false
                cell.peiceText.isHidden = false
                break
            default:
                break
            }
            cell.status.tag = indexPath.row
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! StoreSettingOrderOptionTVCell
            cell.status.tag = indexPath.row
            cell.deleteBtn.tag = indexPath.row
            cell.editBtn.tag = indexPath.row
            
            cell.neme.text = self.orderOptionVos[indexPath.row].option_name
            cell.status.isOn = SwitchStatus.of(name: self.orderOptionVos[indexPath.row].status).status()
            return cell
        default:
             return UITableViewCell.init()
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
