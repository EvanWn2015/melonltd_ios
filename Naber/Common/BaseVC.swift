//
//  CommonVC.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/24.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
import Firebase

class BaseVC: UIViewController{
    let USER_TYPES: [Identity] = Identity.getUserValues()
    
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var intro: UIImageView!

    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btn.isEnabled = false
        self.btn.isHidden = true
        if UIDevice.current.model.range(of: "iPad") != nil{
            self.btn.isHidden = true
            self.intro.isHidden = true
        } else {
//            self.btn.isHidden = false
            self.intro.isHidden = false
            ApiManager.appIntroBulletin(ui: self, onSuccess: { url in
                self.intro.setImage(with: URL(string: url), transformer: TransformerHelper.transformer(identifier: url),  completion: { image in
                    self.btn.isEnabled = true
                    self.btn.isHidden = false
//                    // TODO debug
//                    self.checkLoginAccount()
                })
            }) { err_msg in
                    self.btn.isEnabled = true
                    self.btn.isHidden = false
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 取得 FireBase 權限
        if Model.CURRENT_FIRUSER == nil {
            Auth.auth().signIn(withEmail: "naber_android@gmail.com", password: "melonltd1102") { (user, error) in
                Model.CURRENT_FIRUSER = user?.user
            }
        }
    }
    

    // 判斷是否登入過無超過兩週，並判斷上次登入的帳號類別
    override func viewDidAppear(_ animated: Bool) {
        ApiManager.checkAppVersion(ui: self, onSuccess: { appVersion in
            if let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")! as? String {
                if !appVersion.version.elementsEqual(version) {
                    let alert = UIAlertController(title: "NABER 系統提示", message: "您目前的APP版本(V" + version + ")，不是最新版本(V" + appVersion.version + ")，\n為了您的使用權益，請前往App Store更新您的App", preferredStyle: .alert)
                    
                    if appVersion.need_upgrade.elementsEqual("Y") {
                        alert.addAction(UIAlertAction(title: "前往更新", style: .default){ _ in
                            let urlStr = "https://itunes.apple.com/us/app/naber/id1426204136?l=zh&ls=1&mt=8"
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(URL(string: urlStr)!, options: [ : ], completionHandler: { success in
                                })
                            } else {
                                UIApplication.shared.openURL(URL(string: urlStr)!)
                            }
                        })
                    }else {
                        alert.addAction(UIAlertAction(title: "我知道了", style: .default) { _ in
                            if UIDevice.current.model.range(of: "iPad") != nil{
                                self.startUse()
                            }
                        })
                    }
                    self.present(alert, animated: false)
                }else {
                    if UIDevice.current.model.range(of: "iPad") != nil{
                        self.startUse()
                    }
                }
            }
        }) { err_msg in
            if UIDevice.current.model.range(of: "iPad") != nil{
                self.startUse()
            }
        }

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    @IBAction func goToNext(_ sender: UIButton) {
        self.checkLoginAccount()
    }
    
    func checkLoginAccount(){
//        let now: Int = Int(Date().timeIntervalSince1970 * 1000)
//        if now - NaberConstant.REMEMBER_DAY < UserSstorage.getLoginTime() {
//            let account: AccountInfoVo? = UserSstorage.getAccountInfo()
//            if self.USER_TYPES.contains(Identity(rawValue: (account?.identity)!)!) {
//                // 已登入使用者
//                if let vc = UIStoryboard(name: UIIdentifier.USER.rawValue, bundle: nil).instantiateViewController(withIdentifier: "UserPage") as? UserPageUITabBarController {
//                    self.present(vc, animated: false, completion: nil)
//                }
//            } else if Identity.SELLERS == Identity(rawValue: (account?.identity)!)! {
//                // 已登入過商家
//                if let vc = UIStoryboard(name: UIIdentifier.STORE.rawValue, bundle: nil).instantiateViewController(withIdentifier: "StorePage") as? StorePageUITabBarController {
//                    self.present(vc, animated: false, completion: nil)
//                }
//            } else {
//                UserSstorage.clearUserData()
//                if let vc = UIStoryboard(name: UIIdentifier.MAIN.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC {
//                    self.present(vc, animated: false, completion: nil)
//                }
//            }
//        } else {
//            if let vc = UIStoryboard(name: UIIdentifier.MAIN.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC {
//                self.present(vc, animated: false, completion: nil)
//            }
//        }
        
        
        
        // 更改為 如果沒登出就一直保持登入狀態
        if let account: AccountInfoVo = UserSstorage.getAccountInfo() {
            if self.USER_TYPES.contains(Identity(rawValue: (account.identity)!)!) {
                // 已登入使用者
                if let vc = UIStoryboard(name: UIIdentifier.USER.rawValue, bundle: nil).instantiateViewController(withIdentifier: "UserPage") as? UserPageUITabBarController {
                    self.present(vc, animated: false, completion: nil)
                }
            } else if Identity.SELLERS == Identity(rawValue: (account.identity)!)! {
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
        }else {
            UserSstorage.clearUserData()
            if let vc = UIStoryboard(name: UIIdentifier.MAIN.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC {
                self.present(vc, animated: false, completion: nil)
            }
        }
       
    }
    
    func startUse (){
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
            "1000點 -> MYCARD 300P (點數卡)\n\n" +
            "* 10月開始兌換獎勵及現金折抵\n" +
            "* 消費10元獲得1點紅利點數\n"
        
        let alert = UIAlertController(title: "用NABER訂餐享10%紅利回饋\n紅利兌換項目", message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "開始使用", style: .default){ _ in
            self.checkLoginAccount()
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
