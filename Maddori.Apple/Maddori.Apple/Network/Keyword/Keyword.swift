//
//  Keyword.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/21.
//

import UIKit

struct Keyword {
    let string: String
    var type: KeywordType
    let from: String
    let to: String
    
    init(string: String, type: KeywordType, from: String, to: String) {
        self.string = string
        self.type = type
        self.from = from
        self.to = to
    }
    
    #if DEBUG
    static let mockData: [Keyword] = [
//        Keyword(string: "밥", type: .defaultKeyword, from: "이드", to: "진저"),
//        Keyword(string: "회의왕", type: .defaultKeyword, from: "이드", to: "진저"),
//        Keyword(string: "과몰입", type: .defaultKeyword, from: "이드", to: "진저"),
//        Keyword(string: "사과처럼🍎", type: .defaultKeyword, from: "케미", to: "진저"),
//        Keyword(string: "회고마스터", type: .defaultKeyword, from: "케미", to: "진저"),
//        Keyword(string: "🧨", type: .defaultKeyword, from: "케미", to: "진저"),
//        Keyword(string: "👕", type: .defaultKeyword, from: "케미", to: "진저"),
//        Keyword(string: "내돈을가져가", type: .defaultKeyword, from: "이드", to: "진저"),
//        Keyword(string: "👕", type: .defaultKeyword, from: "이드", to: "진저"),
//        Keyword(string: "👕", type: .defaultKeyword, from: "케미", to: "진저"),
    ]
    
//    static let mockData: [Keyword] = []
    #endif
}
