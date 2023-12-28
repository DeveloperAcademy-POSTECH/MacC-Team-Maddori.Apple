//
//  AllFeedBackResponse.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Foundation

struct TeamFeedbackResponseDTO: Decodable {
    // MARK: - getTeamAndUserFeedback
    let category: String?
    let userFeedback: [FeedbackInfo]?
    let teamFeedback: [FeedbackInfo]?
    
    enum CodingKeys: String, CodingKey {
        case category
        case userFeedback = "user_feedback"
        case teamFeedback = "team_feedback"
    }
}

extension TeamFeedbackResponseDTO {
    func toEntity() -> TeamFeedback {
        return TeamFeedback(category: self.category ?? "",
                            myFeedback: self.userFeedback ?? [],
                            otherFeedback: self.teamFeedback ?? [])
    }
}
