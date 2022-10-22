//
//  Keyword.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/21.
//

import UIKit

struct Keyword {
    let string: String
    let type: KeywordType
    
    init(string: String, type: KeywordType) {
        self.string = string
        self.type = type
    }
    static let mockData: [Keyword] = [
        Keyword(string: "밥", type: .disabledKeyword),
        Keyword(string: "회의왕", type: .disabledKeyword),
        Keyword(string: "과몰입", type: .previewKeyword),
        Keyword(string: "사과처럼🍎", type: .subKeyword),
        Keyword(string: "회고마스터", type: .previewKeyword),
        Keyword(string: "🧨", type: .previewKeyword),
        Keyword(string: "내돈을가져가", type: .defaultKeyword),
        Keyword(string: "패셔니스타👕", type: .disabledKeyword),
    ]
}

//#if DEBUG
//let mockData: [Keyword] = [
//    Keyword(string: "밥", type: .disabledKeyword),
//    Keyword(string: "회의왕", type: .disabledKeyword),
//    Keyword(string: "과몰입", type: .previewKeyword),
//    Keyword(string: "사과처럼🍎", type: .subKeyword),
//    Keyword(string: "회고마스터", type: .previewKeyword),
//    Keyword(string: "🧨", type: .previewKeyword),
//    Keyword(string: "내돈을가져가", type: .defaultKeyword),
//    Keyword(string: "패셔니스타👕", type: .disabledKeyword),
//
//]
//#endif
