//
//  SetupEndPoint.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Alamofire

enum SetupEndPoint<T: Encodable>: EndPointable {
    case dispatchLogin(T)
    case dispatchCreateTeam(T)
    case dispatchJoinTeam(teamId: Int)
    case fetchCertainTeam(invitationCode: String)
    case dispatchAppleLogin(T)
    
    var address: String {
        switch self {
        case .dispatchLogin:
            return "\(UrlLiteral.baseUrl)/users/login"
        case .dispatchCreateTeam:
            return "\(UrlLiteral.baseUrl)/teams"
        case .dispatchJoinTeam(let teamId):
            return "\(UrlLiteral.baseUrl)/users/join-team/\(teamId)"
        case .fetchCertainTeam(let invitationCode):
            return "\(UrlLiteral.baseUrl)/teams?invitation_code=\(invitationCode)"
        case .dispatchAppleLogin:
            return "http://15.165.21.115:3000/api/v1/login"
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
        case .dispatchAppleLogin:
            return .post
        }
    }
    
    var body: T? {
        switch self {
        case .dispatchLogin(let body):
            return body
        case .dispatchCreateTeam(let body):
            return body
        case .dispatchJoinTeam:
            return nil
        case .fetchCertainTeam:
            return nil
        case .dispatchAppleLogin(let body):
            return body
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .dispatchLogin:
            return nil
        case .dispatchCreateTeam:
            let headers = ["user_id": "\(UserDefaultStorage.userId)"]
            return HTTPHeaders(headers)
        case .dispatchJoinTeam:
            let headers = ["user_id": "\(UserDefaultStorage.userId)"]
            return HTTPHeaders(headers)
        case .fetchCertainTeam:
            let headers = ["user_id": "\(UserDefaultStorage.userId)"]
            return HTTPHeaders(headers)
        case .dispatchAppleLogin:
            return nil
        }
    }
}
