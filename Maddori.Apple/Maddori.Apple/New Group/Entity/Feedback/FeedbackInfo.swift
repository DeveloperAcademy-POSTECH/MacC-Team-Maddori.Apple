//
//  FeedbackInfo.swift
//  Maddori.Apple
//
//  Created by 이성민 on 12/29/23.
//

import Foundation

struct FeedbackInfo: Decodable {
    let id: Int
    let type: FeedBackType
    let keyword: String
    let content: String
    let fromUser: UserInfo
    
    enum CodingKeys: String, CodingKey {
        case id, type, keyword, content
        case fromUser = "from_user"
    }
}

extension FeedbackInfo: Hashable {
    static func == (lhs: FeedbackInfo, rhs: FeedbackInfo) -> Bool {
        lhs.id == rhs.id
    }
}
