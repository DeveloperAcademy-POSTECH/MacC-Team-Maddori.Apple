//
//  InProgressEndPoint.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/17.
//

import Foundation

import Alamofire

enum InProgressEndPoint {
    case fetchTeamMembers
    case fetchTeamAndUserFeedback(reflectionId: Int, memberId: Int)
    case patchEndReflection(reflectionId: Int)
    
    var address: String {
        switch self {
        case .fetchTeamMembers:
            return "\(UrlLiteral.baseUrl)/teams/\(UserDefaultStorage.teamId)/members"
        case .fetchTeamAndUserFeedback(let reflectionId, let memberId):
            return "\(UrlLiteral.baseUrl)/teams/\(UserDefaultStorage.teamId)/reflections/\(reflectionId)/feedbacks/from-team?members=\(memberId)"
        case .patchEndReflection(let reflectionId):
            return "\(UrlLiteral.baseUrl)/teams/\(UserDefaultStorage.teamId)/reflections/\(reflectionId)/end"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchTeamMembers:
            return .get
        case .fetchTeamAndUserFeedback:
            return .get
        case .patchEndReflection:
            return .patch
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .fetchTeamMembers:
            let headers = ["user_id": "\(UserDefaultStorage.userId)"]
            return HTTPHeaders(headers)
        case .fetchTeamAndUserFeedback:
            let headers = ["user_id": "\(UserDefaultStorage.userId)"]
            return HTTPHeaders(headers)
        case .patchEndReflection:
            let headers = ["user_id": "\(UserDefaultStorage.userId)"]
            return HTTPHeaders(headers)
        }
    }
}
