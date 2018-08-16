//
//  RecordMainPageViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/28.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit


class RecordMainPageVC: UIViewController ,UITableViewDataSource, UITableViewDelegate{

    var reqData: ReqData!
    var orders : [OrderVo] = []

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
            self.orders.removeAll()
            self.tableView.reloadData()
            self.reqData.page = 0
            self.reqData.loadingMore = true
        }
        
        self.reqData.page = self.reqData.page + 1
        ApiManager.userOrderHistory(req: self.reqData, ui: self, onSuccess: { orders in
            self.orders.append(contentsOf: orders.map({ o -> OrderVo in
                o.order_detail = OrderDetail.parse(src: o.order_data)!
                return o
            }))
            self.reqData.loadingMore = orders.count % NaberConstant.PAGE == 0 && orders.count != 0
            self.tableView.reloadData()
        }) { err_msg in
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reqData = ReqData()
        self.loadData(refresh: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIIdentifier.CELL.rawValue, for: indexPath) as! RecordInfoDetailTVCell
        cell.status.text = self.orders[indexPath.row].status
        cell.recordTime.text = self.orders[indexPath.row].fetch_date
        cell.recordTime.text = DateTimeHelper.formToString(date: self.orders[indexPath.row].fetch_date , from: "dd日 HH時 mm分")
        cell.name.text = self.orders[indexPath.row].order_detail.restaurant_name
        cell.totalPayment.text = "$" + self.orders[indexPath.row].order_price
        let status: OrderStatus = OrderStatus.of(name: self.orders[indexPath.row].status!)
        cell.status.textColor = status.get().color
        cell.status.text = status.get().value
        if self.orders.count - 1 == indexPath.row  && self.reqData.loadingMore {
            self.loadData(refresh: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: UIIdentifier.USER.rawValue, bundle: nil).instantiateViewController(withIdentifier: "RecordInfoDetail") as? RecordInfoDetailVC {
            vc.order = self.orders[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
//        super.show(vc, sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        super.prepare(for: segue, sender: sender)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }
    
}
