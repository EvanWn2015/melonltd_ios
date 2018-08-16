//
//  Model.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/25.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation


class Model {
    
    public static var ADVERTISEMENTS : [AdvertisementVo] = []
    // HOME
    public static var TOP_RESTAURANT_LIST : [RestaurantInfoVo] = []
    // TMPE
    public static var TMPE_RESTAURANT_LIST : [RestaurantInfoVo] = []
    public static var AREA_RESTAURANT_LIST : [RestaurantInfoVo] = []
//    public static var TOP_RESTAURANT_LIST : [RestaurantInfoVo] = []
//    public static var TOP_RESTAURANT_LIST : [RestaurantInfoVo] = []
    public static var ALL_BULLETINS : [String: String] = [:]
    public static var NABER_BULLETINS : [String] = []
    
    public static var USER_CACHE_SHOPPING_CART : [OrderDetail] = []
    
//    var shoppingCartDatas: [OrderDetail] = []
    
//    public static var HONE_ADIMAGES : [UIImageView] = []
    
    public static var SELLER_ORDERS_TIME: String = ""
    
}
