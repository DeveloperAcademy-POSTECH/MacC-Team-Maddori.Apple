//
//  Keyword.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/21.
//

import UIKit

struct Keyword {
    let id: Int
    var style: KeywordType?
    let type: FeedBackType
    let keyword: String
    let content: String
    let startContent: String?
    let fromUser: String
}
