//
//  NaberConstant.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/18.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//
import UIKit
import Foundation

class NaberConstant {
    static let IS_DEBUG : Bool = true
    static let REMEMBER_DAY : Int = 1000 * 60 * 60 * 24 * 7 * 2;
    static let SELLER_STAT_REFRESH_TIMER : Int =  1000 * 60 * 10;
    static let SELLER_LIVE_ORDER_REFRESH_TIMER : Int = 1000 * 60 * 5;
    static let PAGE : Int = 10
    
    static let FILTER_CATEGORYS : [String] = ["早午餐", "西式/牛排", "中式", "日式", "冰飲"]
    static let FILTER_AREAS : [String] = ["桃園區", "中壢區", "平鎮區", "龍潭區", "楊梅區", "新屋區", "觀音區", "龜山區", "八德區", "大溪區", "大園區", "蘆竹區", "復興區"]
    
    static let HOUR_OPT: [String] = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
    static let MINUTE_OPT : [String] = ["00", "30"]
    
    static let FIREBASE_ACCOUNT : String = "naber_android@gmail.com"
    static let FIREBASE_PSW : String = "melonltd1102"
    static let STORAGE_PATH : String = "gs://naber-20180622.appspot.com"
    static let STORAGE_PATH_USER : String = "/user/"
    static let STORAGE_PATH_FOOD : String = "/restaurant/food/"
    
    
    
    static let COLOR_BASIS = UIColor(red:0.93, green:0.89, blue:0.41, alpha:1.0)
    static let COLOR_BASIS_BRIGHT_YELLOW = UIColor(red:1.00, green:0.94, blue:0.21, alpha:1.0)
    static let COLOR_BASIS_RED = UIColor(red:0.92, green:0.13, blue:0.02, alpha:1.0)
    static let COLOR_BASIS_BLUE = UIColor(red:0.11, green:0.64, blue:0.90, alpha:1.0)
    static let COLOR_BASIS_BRIGHT_GREEN = UIColor(red:0.16, green:0.99, blue:0.18, alpha:1.0)
    static let COLOR_BASIS_GREEN = UIColor(red:0.50, green:0.89, blue:0.22, alpha:1.0)
    static let COLOR_BASIS_ORANGE = UIColor(red:0.94, green:0.44, blue:0.29, alpha:1.0)
    static let COLOR_BASIS_PURPLE = UIColor(red:0.52, green:0.49, blue:0.76, alpha:1.0)
}
