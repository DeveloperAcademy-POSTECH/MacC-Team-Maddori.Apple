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
    
    #if DEBUG
    static let mockData: [Keyword] = [
        Keyword(string: "밥", type: .defaultKeyword),
        Keyword(string: "회의왕", type: .defaultKeyword),
        Keyword(string: "과몰입", type: .defaultKeyword),
        Keyword(string: "사과처럼🍎", type: .defaultKeyword),
        Keyword(string: "회고마스터", type: .defaultKeyword),
        Keyword(string: "🧨", type: .defaultKeyword),
        Keyword(string: "내돈을가져가", type: .defaultKeyword),
        Keyword(string: "패셔니스타👕", type: .defaultKeyword),
        
    ]
    #endif

}
