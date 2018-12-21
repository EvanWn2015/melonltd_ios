//
//  IdentityTable.swift
//  Naber
//
//  Created by 王淳彦 on 2018/12/21.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation


class IdentityTableResp: Codable {
    var status : String!
    var err_code : String!
    var err_msg : String!
    var data : [IdentityTableVo] = []
    
    public static func toJson(structs : IdentityTableResp) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> IdentityTableResp? {
        do {
            return try JSONDecoder().decode(IdentityTableResp.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}


class IdentityTableVo: Codable {
    var area: String!
    var identitys : [Identitys]!
    
    public static func toJson(structs : IdentityTableVo) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> IdentityTableVo? {
        do {
            return try JSONDecoder().decode(IdentityTableVo.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}



class Identitys : Codable {
    var name: String!
    var items: [String] = []
    
    public static func toJson(structs : Identitys) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> Identitys? {
        do {
            return try JSONDecoder().decode(Identitys.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
    
}
