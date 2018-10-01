//
//  ErrorModel.swift
//  Bump
//
//  Created by JerryWang on 2018/4/19.
//  Copyright © 2018年 Boshi Li. All rights reserved.
//

import Foundation

// MARK: - Error Model
///status code 400, error message inside
struct ErrorModel: Codable {
    let code: Int
    enum CodingKeys: String, CodingKey {
        case code = "statusCode"
    }
    // TODO: 改為 BUMP 的 Error Status Code
    var errorDescription: String {
        switch self.code {
        case 1: return "API 路徑錯誤"
        case 2: return "所需欄位不存在"
        case 3: return "所需欄位為空"
        case 4: return "欄位長度不符最小值"
        case 5: return "欄位長度不符最大值"
        case 6: return "尚未登入"
        case 7: return "email 格式錯誤"
        case 8: return "驗證連結(忘記密碼信)過期"
        case 9: return "驗證連結(忘記密碼信)錯誤"
        case 10: return "驗證連結裝置不為 Gamplex"
        case 11: return "時間格式錯誤(非timestamp)"
        case 12: return "欄位格式錯誤"
            
        case 100: return "帳號已被註冊"
        case 101: return "email已被註冊"
        case 102: return "登入失效，請重新登入"
        case 103: return "帳號/密碼錯誤"
        case 104: return "用戶不存在"
        case 105: return "密碼兩次輸入不同"
        case 106: return "本次修改密碼與前次密碼相同"
        case 107: return "時間戳為未來時間"
        case 108: return "查無該遊戲"
        default:
            return "Unexpect code, please find backend adminstor"
        }
    }
}
