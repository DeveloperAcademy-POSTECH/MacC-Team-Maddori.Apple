//
//  TeamInfoEndPoint.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2023/03/16.
//

import Alamofire

enum TeamInfoEndPoint<T: Encodable>: EndPointable {
    case fetchUserTeamList
    
    var address: String {
        switch self {
        case .fetchUserTeamList:
            return "\(UrlLiteral.baseUrl2)/users/teams"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchUserTeamList:
            return .get
        }
    }
    
    var body: T? {
        switch self {
        case .fetchUserTeamList:
            return nil
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .fetchUserTeamList:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
        }
    }
}
