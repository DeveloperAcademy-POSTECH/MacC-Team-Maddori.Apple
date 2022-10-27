//
//  ResponseCreateCss.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/26.
//

import Foundation

struct ResponseCreateCss: Decodable {
    let id: Int?
    let from_name: String?
    let to_name: String?
    let type: String?
    let keyword: String?
    let content: String?
    let start_content: String?
}
