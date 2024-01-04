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

extension FeedbackInfo {
    static func dummy() -> [FeedbackInfo] {
        return [
            .init(id: 0, type: .continueType, keyword: "testawvaweio1", content: "test2", fromUser: .init(id: 9, nickname: "test3")),
            .init(id: 1, type: .continueType, keyword: "2", content: "test2", fromUser: .init(id: 9, nickname: "test3")),
            .init(id: 2, type: .continueType, keyword: "afe3", content: "test2", fromUser: .init(id: 9, nickname: "test3")),
            .init(id: 3, type: .continueType, keyword: "afr4", content: "test2", fromUser: .init(id: 9, nickname: "test3")),
            .init(id: 4, type: .continueType, keyword: "a5", content: "test2", fromUser: .init(id: 9, nickname: "test3")),
        ]
    }
    
    static func dummySub() -> [FeedbackInfo] {
        return [
            .init(id: 5, type: .continueType, keyword: "testawvaweio1", content: "test2", fromUser: .init(id: 9, nickname: "test3")),
            .init(id: 6, type: .continueType, keyword: "2", content: "test2", fromUser: .init(id: 9, nickname: "test3")),
            .init(id: 7, type: .continueType, keyword: "afe3", content: "test2", fromUser: .init(id: 9, nickname: "test3")),
            .init(id: 8, type: .continueType, keyword: "afr4", content: "test2", fromUser: .init(id: 9, nickname: "test3")),
            .init(id: 9, type: .continueType, keyword: "a5", content: "test2", fromUser: .init(id: 9, nickname: "test3")),
        ]
    }
}
