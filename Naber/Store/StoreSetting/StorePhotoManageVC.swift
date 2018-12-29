//
//  StorePhotoManageVC.swift
//  Naber
//
//  Created by 王淳彦 on 2018/12/29.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
import Photos
import Firebase

class StorePhotoManageVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var restaurantPhotoRels: [RestaurantPhotoRelVo] = []
    var SELECT_INDEX: Int = -1
    var RESTAURANT_UUD : String = ""
    @IBOutlet weak var addBtn: UIButton!
    
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
            self.restaurantPhotoRels.removeAll()
            self.tableView.reloadData()
        }
        ApiManager.getSellerPhotoList(ui: self, onSuccess: { restaurantPhotoRels in
            self.restaurantPhotoRels.append(contentsOf: restaurantPhotoRels)
            self.tableView.reloadData()
        }) { err_msg in
            print(err_msg)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData(refresh: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.RESTAURANT_UUD = (UserSstorage.getAccountInfo()?.restaurant_uuid)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func addPhotoAction(_ sender: UIButton) {
        self.SELECT_INDEX = -1
        self.showPhotoOption()
    }
    
    @IBAction func updatePhotoAction(_ sender: UIButton) {
        self.SELECT_INDEX = sender.tag
        self.showPhotoOption()
    }
    
    func showPhotoOption(){
        let picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        
        let alert = UIAlertController.init(title: Optional.none , message: Optional.none , preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "相機", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "相簿", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        
        alert.addAction(UIAlertAction(title: "取消", style: .destructive))
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect.init(x: self.view.bounds.width/2 ,y: self.view.bounds.height , width: 1.0, height: 1.0)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deletePhotoAction(_ sender: UIButton) {
        
        let alert = UIAlertController.init(title: "", message: "您確認要刪除圖片？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "確定", style: .default, handler: { _ in
            let req: ReqData = ReqData()
            req.id = self.restaurantPhotoRels[sender.tag].id
            ApiManager.deleteSellerPhoto(req: req, ui: self, onSuccess: { resp in
                print(resp)
                self.restaurantPhotoRels.remove(at: sender.tag)
                self.tableView.reloadData()
            }) { err_msg in
                print(err_msg)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "取消", style: .destructive))
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect.init(x: self.view.bounds.width/2 ,y: self.view.bounds.height , width: 1.0, height: 1.0)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurantPhotoRels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIIdentifier.CELL.rawValue, for: indexPath) as! StorePhotoManageTVCell
        
        cell.editBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        let url: String = self.restaurantPhotoRels[indexPath.row].photo
        cell.photo?.setImage(with: URL(string: url), transformer: TransformerHelper.transformer(identifier: url),  completion: { image in
            if image == nil {
                cell.photo?.image = UIImage(named: "NaberBaseImage")
            }
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func openPhotoLibrary(){
        let pickCtl: UIImagePickerController = UIImagePickerController.init()
        if  UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            PHPhotoLibrary.requestAuthorization({ status in
                if status == .authorized {
                    pickCtl.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
                    pickCtl.sourceType = .photoLibrary;
                    pickCtl.allowsEditing = true
                    self.present(pickCtl, animated: true, completion: Optional.none)
                }else if status == .denied || status == .restricted {
                    self.showAlert(withTitle: "相簿權限已關閉", andMessage: "如要開啟相簿權限，可以點\"前往設置\"，\n將相簿讀取和寫入權限開啟。", isGoSetting: true)
                }
            })
        }else {
            self.showAlert(withTitle: "沒有相簿功能", andMessage: "You can't take photo, there is no photo library.", isGoSetting: false)
        }
    }
    
    func openCamera() {
        let pickCtl: UIImagePickerController = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { _ in
                let status: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
                if status == .authorized {
                    pickCtl.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
                    pickCtl.sourceType = .camera
                    pickCtl.allowsEditing = true
                    self.present(pickCtl, animated: true, completion: Optional.none)
                }else if  status == .denied || status == .restricted {
                    self.showAlert(withTitle: "相機權限已關閉", andMessage: "如要開啟相機權限，可以點\"前往設置\"，\n將相機權限開啟。", isGoSetting: true)
                }
            })
        } else {
            self.showAlert(withTitle: "沒有相機設備", andMessage: "You can't take photo, there is no camera.", isGoSetting: false)
        }
    }
    
    // 可選去設定頁面
    func showAlert(withTitle title: String, andMessage message: String , isGoSetting: Bool) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if isGoSetting {
            alert.addAction(UIAlertAction(title: "前往設置", style: .default) { _ in
                let url = URL(string: UIApplicationOpenSettingsURLString)
                if UIApplication.shared.canOpenURL(url!){
                    UIApplication.shared.open(url!, options: [:])
                }
            })
            alert.addAction(UIAlertAction(title: "返回", style: .destructive))
        } else {
            alert.addAction(UIAlertAction(title: "我知道了", style: .default))
        }
        self.present(alert, animated: true)
    }
    
    // 接到相機 ＆ 相簿回傳的data
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let resizedImage: UIImage = ImageHelper.resizeImage(originalImage: originalImage, minLenDP: 100)
        
        let req: RestaurantPhotoRelVo = RestaurantPhotoRelVo()
        var fileName: String = ""
        if (self.SELECT_INDEX >= 0) { // update
            fileName += self.RESTAURANT_UUD + "_" + self.SELECT_INDEX.description + ".jpg"
            req.id = self.restaurantPhotoRels[self.SELECT_INDEX].id
        } else { // add
            fileName += self.RESTAURANT_UUD + "_" + self.restaurantPhotoRels.count.description + ".jpg"
        }
    
        let sourcePath: String = NaberConstant.STORAGE_PATH_PHOTO + self.RESTAURANT_UUD + "/"
        
        ImageHelper.upLoadImage(data: UIImageJPEGRepresentation(resizedImage, 1.0)!, sourcePath: sourcePath, fileName: fileName, onGetUrl: { url in
            req.photo = url.absoluteString
            ApiManager.uploadSellerPhoto(req: req, ui: self, onSuccess: { resp in
                if (self.SELECT_INDEX >= 0) { // update
                    self.restaurantPhotoRels[self.SELECT_INDEX] = resp
                }else {
                    self.restaurantPhotoRels.append(resp)
                }
                self.tableView.reloadData()
                
            }, onFail: { err_msg in
                print(err_msg)
            })
        }) { err_msg in
            print(err_msg)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
