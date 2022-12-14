//
//  FeedBackInfoResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct FeedBackInfoResponse: Decodable {
    // MARK: - getFromMeToCertainMemberFeedbackAll
    let teamId: Int?
    let reflectionId: Int?
    let reflectionName: String?
    let reflectionStatus: String?
    let fromId: Int?
    let toId: Int?
    let toUsername: String?
    let continueArray: [KeywordResponse]
    let stopArray: [KeywordResponse]
    
    enum CodingKeys: String, CodingKey {
        case teamId = "team_id"
        case reflectionId = "reflection_id"
        case reflectionName = "reflection_name"
        case reflectionStatus = "reflection_status"
        case fromId = "from_id"
        case toId = "to_id"
        case toUsername = "to_username"
        case continueArray = "Continue"
        case stopArray = "Stop"
    }
}
