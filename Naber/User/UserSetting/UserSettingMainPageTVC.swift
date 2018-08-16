//
//  UserSettingMainPageTableViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/24.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class UserSettingMainPageTVC: UITableViewController {

    var account: AccountInfoVo!
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var accunt: UILabel!
    @IBOutlet weak var bonus: UILabel!
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var sound: UISwitch!
    @IBOutlet weak var shake: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.sound.isOn = UserSstorage.getSound()!;
        self.shake.isOn = UserSstorage.getShake()!;
        if let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")! as? String {
             self.version.text = "V." + version
        }
        
        ApiManager.userFindAccountInfo(ui: self, onSuccess: { account in
            
            self.account = account
            self.accunt.text = account?.account
            self.bonus.text = account?.bonus
            
            if account?.photo == nil || account?.photo == "" {
                self.photo.image = UIImage(named: "白底黃閃電")
            } else {
                self.photo?.setImage(with: URL(string: (account?.photo)!), transformer: TransformerHelper.transformer(identifier: (account?.photo)!))
            }
        }) { err_msg in
            print(err_msg)
        }
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        if let nvc: UserSettingAccountDetailTVC = vc as? UserSettingAccountDetailTVC {
            nvc.account = self.account
            self.navigationController?.pushViewController(nvc, animated: true)
        }else {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    

     @IBAction func changeSound(_ sender: UISwitch) {
        UserSstorage.setSound(sender.isOn)
    }
    
    @IBAction func changeShake(_ sender: UISwitch) {
        UserSstorage.setShake(sender.isOn)
    }
}
