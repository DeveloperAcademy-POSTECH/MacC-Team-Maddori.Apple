//
//  KeywordResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Foundation

struct KeywordResponse: Decodable {
    let keyword: String?
    let content: String?
    let start_content: String?
}
