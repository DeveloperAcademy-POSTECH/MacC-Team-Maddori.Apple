//
//  KeywordResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Foundation

struct KeywordResponse: Decodable {
    let id: Int?
    let keyword: String?
    let content: String?
    let startContent: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case keyword
        case content
        case startContent = "start_content"
    }
}
