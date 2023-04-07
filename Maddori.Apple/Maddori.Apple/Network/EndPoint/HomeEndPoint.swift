//
//  HomeEndPoint.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/16.
//

import Alamofire

enum HomeEndPoint<T: Encodable>: EndPointable {
    case fetchCertainTeamDetail
    case fetchCurrentReflectionDetail
    
    var address: String {
        switch self {
        case .fetchCertainTeamDetail:
            return "\(UrlLiteral.baseUrl)/teams/\(UserDefaultStorage.teamId)"
        case .fetchCurrentReflectionDetail:
            return "\(UrlLiteral.baseUrl2)/teams/\(UserDefaultStorage.teamId)/reflections/current"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchCertainTeamDetail:
            return .get
        case .fetchCurrentReflectionDetail:
            return .get
        }
    }
    
    var body: T? {
        switch self {
        case .fetchCertainTeamDetail:
            return nil
        case .fetchCurrentReflectionDetail:
            return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .fetchCertainTeamDetail:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
        case .fetchCurrentReflectionDetail:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
        }
    }
}
