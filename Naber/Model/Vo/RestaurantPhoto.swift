//
//  RestaurantPhoto.swift
//  Naber
//
//  Created by 王淳彦 on 2018/12/28.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

// type = STORE, FOOD

import Foundation


class RestaurantPhotoResp: Codable {
    var status : String!
    var err_code : String!
    var err_msg : String!
    var data : [RestaurantPhotoVo] = []
    
    public static func toJson(structs : RestaurantPhotoResp) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> RestaurantPhotoResp? {
        do {
            return try JSONDecoder().decode(RestaurantPhotoResp.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}


class RestaurantPhotoVo: Codable {
    var type: String!
    var photo: String!
    var uuid: String!
    var name: String!
    
    public static func toJson(structs : RestaurantPhotoVo) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> RestaurantPhotoVo? {
        do {
            return try JSONDecoder().decode(RestaurantPhotoVo.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
    
    public static func parseArray(src: String) -> [RestaurantPhotoVo] {
        do {
            return try JSONDecoder().decode([RestaurantPhotoVo].self, from: src.data(using:.utf8)!)
        }catch {
            return []
        }
    }
    
}
