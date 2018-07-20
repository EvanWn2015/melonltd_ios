//
//  RespData.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/18.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation

struct RespData : Codable {
    var status : String!
    var err_code : String!
    var err_msg : String!
    var data : String!
    
    public static func toJson(account : RespData) -> String {
        do {
            return String(data: try JSONEncoder().encode(account), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> RespData? {
        do {
            return try JSONDecoder().decode(RespData.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}
