//
//  InProgressEndPoint.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/17.
//

import Foundation

import Alamofire

enum InProgressEndPoint<T: Encodable>: EndPointable {
    case fetchTeamMembers
    case fetchTeamAndUserFeedback(reflectionId: Int, memberId: Int)
    case patchEndReflection(reflectionId: Int)
    
    var address: String {
        switch self {
        case .fetchTeamMembers:
            return "\(UrlLiteral.baseUrl2)/teams/\(UserDefaultStorage.teamId)/members"
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
    
    var body: T? {
        switch self {
        case .fetchTeamMembers:
            return nil
        case .fetchTeamAndUserFeedback:
            return nil
        case .patchEndReflection:
            return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .fetchTeamMembers:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
        case .fetchTeamAndUserFeedback:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
        case .patchEndReflection:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
        }
    }
}
