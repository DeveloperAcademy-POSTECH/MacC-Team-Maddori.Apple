//
//  Keyword.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/21.
//

import UIKit

struct Keyword {
    let keyword: String
    let type: KeywordType
    
    init(keyword: String, type: KeywordType) {
        self.keyword = keyword
        self.type = type
    }
}

let mockData: [Keyword] = [
    Keyword(keyword: "첫 번째", type: .defaultKeyword),
    Keyword(keyword: "키워드를", type: .defaultKeyword),
    Keyword(keyword: "작성해주세요", type: .defaultKeyword),
    Keyword(keyword: "아래", type: .defaultKeyword),
    Keyword(keyword: "버튼으로", type: .defaultKeyword),
]
