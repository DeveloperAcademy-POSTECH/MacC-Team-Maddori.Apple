//
//  BaseModel.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct BaseModel<T: Decodable>: Decodable {
    let success: Bool
    let message: String
    let detail: T?
}
