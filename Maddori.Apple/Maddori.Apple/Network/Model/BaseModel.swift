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
    
    // FIXME: - 서버에서 오타 수정되면 enum이 삭제되어야함
    enum CodingKeys: String, CodingKey {
        case success
        case message
        case detail = "datail"
    }
}
