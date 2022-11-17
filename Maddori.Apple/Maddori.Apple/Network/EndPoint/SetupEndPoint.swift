//
//  SetupEndPoint.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Alamofire

enum SetupEndPoint<T: Encodable> {
    case dispatchLogin(T)
    case dispatchCreateTeam(T, userId: String)
    case dispatchJoinTeam(teamId: Int, userId: String)
    case fetchCertainTeam(invitationCode: String, userId: String)
    
    var address: String {
        switch self {
        case .dispatchLogin:
            return "\(UrlLiteral.baseUrl)/users/login"
        case .dispatchCreateTeam:
            return "\(UrlLiteral.baseUrl)/teams"
        case .dispatchJoinTeam(let teamId, _):
            return "\(UrlLiteral.baseUrl)/users/join-team/\(teamId)"
        case .fetchCertainTeam(let invitationCode, _):
            return "\(UrlLiteral.baseUrl)/teams?invitation_code=\(invitationCode)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .dispatchLogin:
            return .post
        case .dispatchCreateTeam:
            return .post
        case .dispatchJoinTeam:
            return .post
        case .fetchCertainTeam:
            return .get
        }
    }
    
    var body: T? {
        switch self {
        case .dispatchLogin(let body):
            return body
        case .dispatchCreateTeam(let body, _):
            return body
        case .dispatchJoinTeam:
            return nil
        case .fetchCertainTeam:
            return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .dispatchLogin:
            return nil
        case .dispatchCreateTeam(_, let userId):
            let headers = ["user_id": userId]
            return HTTPHeaders(headers)
        case .dispatchJoinTeam(_, let userId):
            let headers = ["user_id": userId]
            return HTTPHeaders(headers)
        case .fetchCertainTeam(_, let userId):
            let headers = ["user_id": userId]
            return HTTPHeaders(headers)
        }
    }
}
