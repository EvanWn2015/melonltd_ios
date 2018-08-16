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
    static let IS_DEBUG : Bool = false
    static let REMEMBER_DAY : Int = 1000 * 60 * 60 * 24 * 7 * 2;
    static let SELLER_STAT_REFRESH_TIMER : Double =  1000 * 60 * 10;
    static let SELLER_LIVE_ORDER_REFRESH_TIMER : Double = 1000 * 60 * 5;
    static let PAGE : Int = 10
    
    static let FILTER_CATEGORYS : [String] = ["早午餐", "西式/牛排", "中式", "日式", "冰飲"]
    static let FILTER_AREAS : [String] = ["桃園區", "中壢區", "平鎮區", "龍潭區", "楊梅區", "新屋區", "觀音區", "龜山區", "八德區", "大溪區", "大園區", "蘆竹區", "復興區"]
    
    static let HOUR_MINUTE_OPT: [[String]] = [["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"], ["00", "30"]]
    
    static let HOUR_OPT: [String] = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
    static let MINUTE_OPT : [String] = ["00", "30"]
    
    static let FIREBASE_ACCOUNT : String = "naber_android@gmail.com"
    static let FIREBASE_PSW : String = "melonltd1102"
    static let STORAGE_PATH : String = "gs://naber-20180622.appspot.com"
    static let STORAGE_PATH_USER : String = "/user/"
    static let STORAGE_PATH_FOOD : String = "/restaurant/food/"
    
    static let IDENTITY_OPTS_TEMP : [String:[String]] =
        ["大學/大專院校生":["中央大學","體育大學","海洋大學(桃園校區)","中原大學","長庚大學","元智大學","開南大學","銘傳大學","臺北商業大學(桃園校區)","臺北科技大學(桃園校區)","健行科大","龍華科大","萬能科大","長庚科大","南亞技術學院","新生醫護專科","陸軍專科學校","其他"],
         "高中生":["桃園農工","武陵高中","振聲高中","陽明高中","桃園高中","新興高中","中大附中","中壢高商","中壢家商","內壢高中","啟英高中","平鎮高中","育達高中","六和高中","復旦高中","永豐高中","新興高中","楊梅高中","治平高中","永平高中","大華高中","至善高中","大溪高中","南崁高中","龍潭高中","方曙商工","漢英高中","成功工商","光啟高中","壽山高中","大園高中","大興高中","觀音高中","新屋高中","清華高中","其他"],
         "國中生":["桃園國中","青溪國中","文昌國中","建國國中","中興國中","慈文國中","福豐國中","同德國中","會稽國中","大有國中","振聲國中","新興國中","新明國中","內壢國中","龍岡國中","大崙國中","興南國中","自強國中","東興國中","龍興國中","過嶺國中","青埔國中","有得國中","中壢國中","平鎮國中","平南國中","平興國中","東安國中","復旦國中","六和國中","八德國中","大成國中","永豐國中","楊梅國中","仁美國中","富岡國中","瑞原國中","楊明國中","楊光國中","瑞坪國中","治平國中","大華國中","大溪國中","仁和國中","南崁國中","山腳國中","大竹國中","光明國中","龍潭國中","凌雲國中","石門國中","武漢國中","漢英國中","大崗國中","迴龍國中","幸福國中","龜山國中","大園國中","竹圍國中","觀音國中","草漯國中","新屋國中","永安國中","大坡國中","清華國中","介壽國中","桃園特殊教育國中"],
         "小學生":[""],
         "社會人士/其它":[""]]

    static let WEEK_DAY_NAME: [String] = ["日", "ㄧ", "二", "三", "四", "五", "六"]
    
    static let COLOR_BASIS = UIColor(red:0.93, green:0.89, blue:0.41, alpha:1.0)
    static let COLOR_BASIS_BRIGHT_YELLOW = UIColor(red:1.00, green:0.94, blue:0.21, alpha:1.0)
    static let COLOR_BASIS_RED = UIColor(red:0.92, green:0.13, blue:0.02, alpha:1.0)
    static let COLOR_BASIS_BLUE = UIColor(red:0.11, green:0.64, blue:0.90, alpha:1.0)
    static let COLOR_BASIS_BRIGHT_GREEN = UIColor(red:0.16, green:0.99, blue:0.18, alpha:1.0)
    static let COLOR_BASIS_GREEN = UIColor(red:0.50, green:0.89, blue:0.22, alpha:1.0)
    static let COLOR_BASIS_ORANGE = UIColor(red:0.94, green:0.44, blue:0.29, alpha:1.0)
    static let COLOR_BASIS_PURPLE = UIColor(red:0.52, green:0.49, blue:0.76, alpha:1.0)
    static let COLOR_BASIS_GRAY = UIColor(red:0.67, green:0.67, blue:0.67, alpha:1.0)
    
}
