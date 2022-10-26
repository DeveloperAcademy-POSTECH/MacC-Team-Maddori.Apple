//
//  CreateCssDTO.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/26.
//

import Foundation

struct CreateCssDTO: Encodable {
    let from_name: String?
    let to_name: String?
    let type: CSSType?
    let keyword: String?
    let content: String?
    let start_content: String?
}

enum CSSType: String, Encodable {
    case Continue = "Continue"
    case Stop = "Stop"
}
