//
//  CommonVC.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/24.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
//import CoreLocation


class BaseVC: UIViewController{
    let USER_TYPES: [Identity] = Identity.getUserValues()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // 判斷是否登入過無超過兩週，並判斷上次登入的帳號類別
    override func viewDidAppear(_ animated: Bool) {
        
        let msg: String = "\n" +
        "    10點 -> 下次消費折抵3元 (無上限)\n" +
        "  500點 -> KKBOX 30天 (點數卡)\n" +
        "  667點 -> 中壢威尼斯 (電影票)\n" +
        "  767點 -> 桃園IN89統領 (電影票)\n" +
        "  767點 -> 美麗華影城 (電影票)\n" +
        "  800點 -> LINE 240P (點數卡)\n" +
        "  834點 -> SBC星橋 (電影票)\n" +
        "  834點 -> 威秀影城(電影票)\n" +
        "1000點 -> SOGO 300(禮卷)\n" +
        "1000點 -> MYCARD 300P (點數卡)\n" +
        
        
        "\n\n活動說明：\n" +
        "凡是透過NABER訂餐，\n" +
        "一律回饋消費金額之3%紅利點數\n" +
        "，並能兌換NABER所提供之獎勵。\n\n" +
        "* 10月開始兌換獎勵及現金折抵\n" +
        "* 消費10元獲得1點紅利點數\n"
 
        let alert = UIAlertController(title: "用NABER訂餐享3%紅利回饋\n紅利兌換項目", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "開始使用", style: .default){ _ in
            let now: Int = Int(Date().timeIntervalSince1970 * 1000)
            if now - NaberConstant.REMEMBER_DAY < UserSstorage.getLoginTime() {
                let account: AccountInfoVo? = UserSstorage.getAccountInfo()
                if self.USER_TYPES.contains(Identity(rawValue: (account?.identity)!)!) {
                    // 已登入使用者
                    if let vc = UIStoryboard(name: UIIdentifier.USER.rawValue, bundle: nil).instantiateViewController(withIdentifier: "UserPage") as? UserPageUITabBarController {
                        self.present(vc, animated: false, completion: nil)
                    }
                } else if Identity.SELLERS == Identity(rawValue: (account?.identity)!)! {
                    // 已登入過商家
                    if let vc = UIStoryboard(name: UIIdentifier.STORE.rawValue, bundle: nil).instantiateViewController(withIdentifier: "StorePage") as? StorePageUITabBarController {
                        self.present(vc, animated: false, completion: nil)
                    }
                } else {
                    UserSstorage.clearUserData()
                    if let vc = UIStoryboard(name: UIIdentifier.MAIN.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC {
                        self.present(vc, animated: false, completion: nil)
                    }
                }
            } else {
                if let vc = UIStoryboard(name: UIIdentifier.MAIN.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC {
                    self.present(vc, animated: false, completion: nil)
                }
            }
        })
        
        let subView1: UIView = alert.view.subviews[0]
        let subView2: UIView = subView1.subviews[0]
        let subView3: UIView = subView2.subviews[0]
        let subView4: UIView = subView3.subviews[0]
        let subView5: UIView = subView4.subviews[0]
        // let title: UILabel = subView5.subviews[0] as! UILabel
        let message: UILabel = subView5.subviews[1] as! UILabel
        message.textAlignment = .left
        self.present(alert, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
