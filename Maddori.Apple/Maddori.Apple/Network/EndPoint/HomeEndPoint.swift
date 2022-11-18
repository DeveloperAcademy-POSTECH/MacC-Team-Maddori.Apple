//
//  HomeEndPoint.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/16.
//

import Alamofire

enum HomeEndPoint {
    case fetchCertainTeamDetail(teamId: Int)
    case fetchCurrentReflectionDetail(teamId: Int)
    
    var address: String {
        switch self {
        case .fetchCertainTeamDetail(let teamId):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)"
        case .fetchCurrentReflectionDetail(let teamId):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)/reflections/current"
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
