//
//  AddFeedBackContentResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct FeedBackContentResponse: Decodable {
    // MARK: - createFeedback
    let id: Int?
    let type: FeedBackType?
    let keyword: String?
    let content: String?
    let startContent: String?
    let fromId: Int?
    let toId: Int?
    let teamId: Int?
    let reflectionId: Int?
    let fromUser: MemberResponse?
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case keyword
        case content
        case startContent = "start_content"
        case fromId = "from_id"
        case toId = "to_id"
        case teamId = "team_id"
        case reflectionId = "reflection_id"
        case fromUser = "from_user"
    }
}
