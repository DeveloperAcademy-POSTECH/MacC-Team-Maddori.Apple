//
//  CreateCssDTO.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/26.
//

import Foundation

struct CreateCssDTO: Encodable {
    let from_name: String
    let to_name: String
    var type: CSSType
    var keyword: String
    var content: String
    var start_content: String
}

enum CSSType: String, Encodable {
    case Continue = "Continue"
    case Stop = "Stop"
}
