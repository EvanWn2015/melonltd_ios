//
//  RestaurantPhotoRel.swift
//  Naber
//
//  Created by 王淳彦 on 2018/12/29.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation


class RestaurantPhotoRelListResp: Codable {
    var status : String!
    var err_code : String!
    var err_msg : String!
    var data : [RestaurantPhotoRelVo] = []
    
    public static func toJson(structs : RestaurantPhotoRelListResp) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> RestaurantPhotoRelListResp? {
        do {
            return try JSONDecoder().decode(RestaurantPhotoRelListResp.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}

class RestaurantPhotoRelResp: Codable {
    var status : String!
    var err_code : String!
    var err_msg : String!
    var data : RestaurantPhotoRelVo
    
    public static func toJson(structs : RestaurantPhotoRelResp) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> RestaurantPhotoRelResp? {
        do {
            return try JSONDecoder().decode(RestaurantPhotoRelResp.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}


class RestaurantPhotoRelVo: Codable {
    var id: String!
    var restaurant_uuid: String!
    var photo: String!
    var enable: String!
    var status: String!
    var create_date: String!
    
    public static func toJson(structs : RestaurantPhotoRelVo) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> RestaurantPhotoRelVo? {
        do {
            return try JSONDecoder().decode(RestaurantPhotoRelVo.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}
