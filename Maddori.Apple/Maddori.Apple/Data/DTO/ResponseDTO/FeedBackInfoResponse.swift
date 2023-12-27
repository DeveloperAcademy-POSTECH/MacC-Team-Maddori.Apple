//
//  FeedBackInfoResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/15.
//

import Foundation

struct FeedBackInfoResponse: Decodable {
    // MARK: - getFromMeToCertainMemberFeedbackAll
    let toUser: MemberResponse
    let reflection: ReflectionResponse
    let continueArray: [KeywordResponse]
    let stopArray: [KeywordResponse]
    
    enum CodingKeys: String, CodingKey {
        case toUser = "to_user"
        case reflection
        case continueArray = "Continue"
        case stopArray = "Stop"
    }
}
