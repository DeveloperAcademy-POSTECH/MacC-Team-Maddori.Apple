//
//  HomeEndPoint.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/16.
//

import Alamofire

enum HomeEndPoint {
    case fetchCertainTeamDetail(teamId: String, userId: String)
    case fetchCurrentReflectionDetail(teamId: String, userId: String)
    
    var address: String {
        switch self {
        case .fetchCertainTeamDetail(let teamId, _):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)"
        case .fetchCurrentReflectionDetail(let teamId, _):
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
        case .fetchCertainTeamDetail(_, let userId):
            let headers = ["user_id": userId]
            return HTTPHeaders(headers)
        case .fetchCurrentReflectionDetail(_, let userId):
            let headers = ["user_id": userId]
            return HTTPHeaders(headers)
        }
    }
}
