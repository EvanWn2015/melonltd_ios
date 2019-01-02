//
//  RestaurantOrderOption.swift
//  Naber
//
//  Created by 王淳彦 on 2018/12/31.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation

class RestaurantOrderOptionListResp: Codable {

    var status : String!
    var err_code : String!
    var err_msg : String!
    var data : [RestaurantOrderOptionVo] = []
    
    public static func toJson(structs : RestaurantOrderOptionListResp) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> RestaurantOrderOptionListResp? {
        do {
            return try JSONDecoder().decode(RestaurantOrderOptionListResp.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}


class RestaurantOrderOptionResp: Codable {
    var status : String!
    var err_code : String!
    var err_msg : String!
    var data : RestaurantOrderOptionVo
    
    public static func toJson(structs : RestaurantOrderOptionResp) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> RestaurantOrderOptionResp? {
        do {
            return try JSONDecoder().decode(RestaurantOrderOptionResp.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}

class RestaurantOrderOptionVo: Codable {
    var id: String!
    var restaurant_uuid: String!
    var option_name: String!
    var options: [String] = []
    var enable: String!
    var status: String!
    var create_date: String!
    
    public static func toJson(structs : RestaurantOrderOptionVo) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> RestaurantOrderOptionVo? {
        do {
            return try JSONDecoder().decode(RestaurantOrderOptionVo.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
    
    public static func parse(src : String) -> [RestaurantOrderOptionVo]? {
        do {
            return try JSONDecoder().decode([RestaurantOrderOptionVo].self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
    
    public static func of(name option_name: String, opt option: String) -> RestaurantOrderOptionVo {
        let opt: RestaurantOrderOptionVo = RestaurantOrderOptionVo()
        opt.option_name = option_name
        opt.options.append(option)
        return opt
    }

}

//
//// 用於送訂單格式
//class OrderOptionVo: Codable {
////    var id: String!
//    var restaurant_uuid: String!
//    var option_name: String!
//    var options: String!
//    var enable: String!
//    var status: String!
//    var create_date: String!
//    
//    public static func toJson(structs : OrderOptionVo) -> String {
//        do {
//            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
//        } catch {
//            return ""
//        }
//    }
//    
//    public static func parse(src : String) -> OrderOptionVo? {
//        do {
//            return try JSONDecoder().decode(OrderOptionVo.self, from: src.data(using:.utf8)!)
//        }catch {
//            return nil
//        }
//    }
//    
//    public static func of(name option_name: String, opt option: String) -> OrderOptionVo {
//        let opt: OrderOptionVo = OrderOptionVo()
//        opt.option_name = option_name
//        opt.options = option
//        return opt
//    }
//}

