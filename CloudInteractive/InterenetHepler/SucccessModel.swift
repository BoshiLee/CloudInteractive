//
//  SucccessModel.swift
//  Bump
//
//  Created by JerryWang on 2018/4/19.
//  Copyright © 2018年 Boshi Li. All rights reserved.
//

import Foundation

// MARK: - Success Model
/// Use Success Model when there are not reponse any data
struct SucccessModel: Codable {
    let message: String
    enum CodingKeys: String, CodingKey {
        case message = "successMsg"
    }
}
