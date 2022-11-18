//
//  InProgressEndPoint.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/17.
//

import Foundation

import Alamofire

enum InProgressEndPoint {
    case fetchTeamMembers(teamId: Int, userId: Int)
    case fetchTeamAndUserFeedback(teamId: Int, reflectionId: Int, memberId: Int, userId: Int)
    
    var address: String {
        switch self {
        case .fetchTeamMembers(let teamId, _):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)/members"
        case .fetchTeamAndUserFeedback(let teamId, let reflectionId, let memberId, _):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)/reflections/\(reflectionId)/feedbacks/from-team?members=\(memberId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchTeamMembers:
            return .get
        case .fetchTeamAndUserFeedback:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .fetchTeamMembers(_, let userId):
            let headers = ["user_id": "\(userId)"]
            return HTTPHeaders(headers)
        case .fetchTeamAndUserFeedback(_, _, _, let userId):
            let headers = ["user_id": "\(userId)"]
            return HTTPHeaders(headers)
        }
    }
}
