//
//  ViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/20.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging

class LoginVC: UIViewController {
    
    
    let USER_TYPES: [Identity] = Identity.getUserValues()

    @IBOutlet weak var account_text: CustomSearchTextField! 
    @IBOutlet weak var password_text: CustomSearchTextField!
    @IBOutlet weak var register_button: UIButton!
    @IBOutlet weak var store_register_button: UIButton!
//    @IBOutlet weak var rememberMeButton: UIButton!
    @IBOutlet weak var rememberMeImage: UIButton!
 
    @IBOutlet weak var table: UITableView!

    @IBAction func rememberMeSwithOnImage(_ sender: Any) {
        if (rememberMeImage.currentImage?.isEqual(UIImage(named: "cbSelect")))! {
            let image = UIImage(named: "cbNoSelect") as UIImage?
            rememberMeImage.setImage(image, for: .normal)
        }else{
            let image = UIImage(named: "cbSelect") as UIImage?
            rememberMeImage.setImage(image, for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
  
        if UserSstorage.getRememberMe() {
            self.rememberMeImage.setImage(UIImage(named:"cbSelect"), for: .normal)
            self.account_text.text = UserSstorage.getAccount()
        } else {
            self.rememberMeImage.setImage(UIImage(named: "cbNoSelect"), for: .normal)
            UserSstorage.clearAccount()
            self.account_text.text = ""
        }
        
//        if NaberConstant.IS_DEBUG {
//            self.account_text.text = "NER-18X1X14"
//            self.password_text.text = "a123456"
//        }
        
    }
  
    private func verifyInput () -> String {
        var msg: String = ""
        if self.account_text.text == "" {
            msg = "請輸入帳號"
        }
        if self.password_text.text == "" {
            msg = "請輸入密碼"
        }
        if msg != "" {
            let alert = UIAlertController(title: "系統提示", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "取消", style: .default))
            self.present(alert, animated: false)
        }
        return msg
    }
    
    @IBAction func goToNextPage(_ sender: Any) {

        if self.verifyInput() == "" {
            let reqData: AccountInfoVo = AccountInfoVo()
            reqData.phone = self.account_text.text
            reqData.password = self.password_text.text
            reqData.device_category = "IOS"
            reqData.device_token = (UIApplication.shared.delegate as! AppDelegate).token
            
            ApiManager.login(structs: reqData, ui: self, onSuccess: { account in
                if account != nil {
                    let now: Int = DateTimeHelper.getNowMilliseconds()
                    account?.device_token = reqData.device_token
                    account?.device_category = "IOS"
                    UserSstorage.setLoginTime(now)
                    UserSstorage.setAccountInfo(account!)
                    let remember: Bool = (self.rememberMeImage.currentImage?.isEqual(UIImage(named: "cbSelect")))!
                    UserSstorage.setRememberMe(remember)
                    if remember {
                        UserSstorage.setAccount((account?.account)!)
                    }else {
                        UserSstorage.clearAccount()
                    }
                    
                    if self.USER_TYPES.contains(Identity.init(rawValue: (account?.identity.uppercased())!)!) {
                        // 使用者
                        if let vc = UIStoryboard(name: UIIdentifier.USER.rawValue, bundle: nil).instantiateViewController(withIdentifier: "UserPage") as? UserPageUITabBarController {
                            self.present(vc, animated: false, completion: nil)
                        }
                    } else if Identity.SELLERS == Identity.init(rawValue: (account?.identity.uppercased())!)! {
                        // 商家端
                        if let vc = UIStoryboard(name: UIIdentifier.STORE.rawValue, bundle: nil).instantiateViewController(withIdentifier: "StorePage") as? StorePageUITabBarController {
                            self.present(vc, animated: false, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "系統提示", message: "查無此帳號！", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "取消", style: .default))
                        self.present(alert, animated: false)
                    }
                }else {
                    let alert = UIAlertController(title: "系統提示", message: "查無此帳號！", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "取消", style: .default))
                    self.present(alert, animated: false)
                }
            }) { err_msg in
                let alert = UIAlertController(title: "系統提示", message: err_msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "取消", style: .default))
                self.present(alert, animated: false)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // 鍵盤點擊背景縮放
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


