//
//  FeedBackContentResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct FeedBackContentResponse: Decodable {
    // MARK: - createFeedback, updateFeedback
    let id: Int?
    let type: FeedBackType?
    let keyword: String?
    let content: String?
    let toUser: MemberResponse?
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case keyword
        case content
        case toUser = "to_user"
    }
}
