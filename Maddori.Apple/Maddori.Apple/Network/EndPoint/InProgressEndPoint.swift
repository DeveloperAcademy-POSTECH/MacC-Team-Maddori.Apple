//
//  InProgressEndPoint.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/17.
//

import Foundation

import Alamofire

enum InProgressEndPoint {
    case fetchTeamAndUserFeedback(reflectionId: Int, teamId: Int, memberId: Int, userId: Int)
    
    var address: String {
        switch self {
        case .fetchTeamAndUserFeedback(let reflectionId, let teamId, let memberId, _):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)/reflections/\(reflectionId)/feedbacks?members=\(memberId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchTeamAndUserFeedback:
            return .get
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .fetchTeamAndUserFeedback(_, _, _, let userId):
            let headers = ["user_id": "\(userId)"]
            return HTTPHeaders(headers)
        }
    }
}

// 홀리몰리 홀리몰리2 홀리몰리3
// 122 123 124

// 63 9WFXAF

// 67 - 홀리몰리회고
