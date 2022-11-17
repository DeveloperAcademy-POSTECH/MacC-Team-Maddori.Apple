//
//  AddFeedBackEndPoint.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/17.
//

import Foundation

import Alamofire

enum AddFeedBackEndPoint<T: Encodable> {
    case fetchCurrentTeamMember(teamId: Int, userId: Int)
    case dispatchAddFeedBack(teamId: Int, reflectionId: Int, userId: Int, T)
    
    var address: String {
        switch self {
        case .fetchCurrentTeamMember(let teamId, _):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)/members"
        case .dispatchAddFeedBack(let teamId, let reflectionId, _, _):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)/reflections/\(reflectionId)/feedbacks"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchCurrentTeamMember:
            return .get
        case .dispatchAddFeedBack:
            return .post
        }
    }
    
    var body: T? {
        switch self {
        case .fetchCurrentTeamMember:
            return nil
        case .dispatchAddFeedBack(_, _, _, let body):
            return body
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .fetchCurrentTeamMember(_, let userId):
            let headers = ["user_id": "\(userId)"]
            return HTTPHeaders(headers)
        case .dispatchAddFeedBack(_, _, let userId, _):
            let headers = ["user_id": "\(userId)"]
            return HTTPHeaders(headers)
        }
    }
}
