//
//  SetupEndPoint.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Alamofire

enum SetupEndPoint<T: Encodable>: EndPointable {
    case dispatchCreateTeam
    case dispatchJoinTeam(teamId: Int)
    case fetchCertainTeam(invitationCode: String)
    case dispatchAppleLogin(T)
    
    var address: String {
        switch self {
        case .dispatchCreateTeam:
            return "\(UrlLiteral.baseUrl2)/teams"
        case .dispatchJoinTeam(let teamId):
            return "\(UrlLiteral.baseUrl2)/users/join-team/\(teamId)"
        case .fetchCertainTeam(let invitationCode):
            return "\(UrlLiteral.baseUrl2)/teams?invitation_code=\(invitationCode)"
        case .dispatchAppleLogin:
            return "\(UrlLiteral.baseUrl2)/auth"
        }
    }

    var method: HTTPMethod {
        switch self {
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
        case .dispatchCreateTeam:
            return nil
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
        case .dispatchCreateTeam:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)",
                "Content-Type": "multipart/form-data"
            ]
            return HTTPHeaders(headers)
        case .dispatchJoinTeam:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)",
                "Content-Type": "multipart/form-data"
            ]
            return HTTPHeaders(headers)
        case .fetchCertainTeam:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
        case .dispatchAppleLogin:
            return nil
        }
    }
}
