//
//  Keyword.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/21.
//

import UIKit

struct Keyword {
    var style: KeywordType?
    let type: String
    let keyword: String
    let content: String
    let startContent: String?
    let fromUser: String
    
    #if DEBUG
//    static let mockData: [Keyword] = [
//        Keyword(type: .defaultKeyword, string: "밥", from: "이드", to: "진저"),
//        Keyword(type: .defaultKeyword, string: "회의왕", from: "이드", to: "진저"),
//        Keyword(type: .defaultKeyword, string: "과몰입", from: "이드", to: "진저"),
//        Keyword(type: .defaultKeyword, string: "사과처럼🍎", from: "케미", to: "진저"),
//        Keyword(type: .defaultKeyword, string: "회고마스터", from: "케미", to: "진저"),
//        Keyword(type: .defaultKeyword, string: "🧨", from: "케미", to: "진저"),
//        Keyword(type: .defaultKeyword, string: "👕", from: "케미", to: "진저"),
//        Keyword(type: .defaultKeyword, string: "내돈을가져가", from: "이드", to: "진저"),
//        Keyword(type: .defaultKeyword, string: "👕", from: "이드", to: "진저"),
//        Keyword(type: .defaultKeyword, string: "👕", from: "케미", to: "진저"),
//    ]
    static let mockData: [Keyword] = []
    #endif
}
