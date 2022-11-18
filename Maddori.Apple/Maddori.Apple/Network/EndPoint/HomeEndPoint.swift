//
//  HomeEndPoint.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/16.
//

import Alamofire

enum HomeEndPoint {
    case fetchCertainTeamDetail
    case fetchCurrentReflectionDetail
    
    var address: String {
        switch self {
        case .fetchCertainTeamDetail:
            return "\(UrlLiteral.baseUrl)/teams/\(UserDefaultStorage.teamId)"
        case .fetchCurrentReflectionDetail:
            return "\(UrlLiteral.baseUrl)/teams/\(UserDefaultStorage.teamId)/reflections/current"
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
    
    var header: HTTPHeaders {
        switch self {
        case .fetchCertainTeamDetail:
            let headers = ["user_id": "\(UserDefaultStorage.userId)"]
            return HTTPHeaders(headers)
        case .fetchCurrentReflectionDetail:
            let headers = ["user_id": "\(UserDefaultStorage.userId)"]
            return HTTPHeaders(headers)
        }
    }
}
