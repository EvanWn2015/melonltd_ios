//
//  ReqData.swift
//  Naber
//
//  Created by melon on 2018/7/20.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation


class ReqData : Codable {
    var uuid: String!
    var page: Int! = 0
    var top: Int! = 0
    var phone: String!
    var old_password: String!
    var password: String!
    var email: String!
    var date: String!
    var status: String!
    var search_type: String!
    var uuids: [String]! = []
    var category: String!
    var area: String!
   
    public static func toJson(structs : ReqData) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
//
//    public static func parse(src : String) -> BulletinResp? {
//        do {
//            return try JSONDecoder().decode(BulletinResp.self, from: src.data(using:.utf8)!)
//        }catch {
//            return nil
//        }
//    }
}