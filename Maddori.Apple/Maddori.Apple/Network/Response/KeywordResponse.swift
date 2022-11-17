//
//  KeywordResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Foundation

struct KeywordResponse: Decodable {
    // FIXME: - 사용이 안되는 거 같은데 ???
    let keyword: String?
    let content: String?
    let startContent: String?
    
    enum CodingKeys: String, CodingKey {
        case keyword
        case content
        case startContent = "start_content"
    }
}
