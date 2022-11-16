//
//  SetupEndPoint.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Alamofire

enum SetupEndPoint<T: Encodable> {
    case login(T)
    case createTeam(T, userId: String)
    case joinTeam(T, userId: String)
    
    var address: String {
        switch self {
        case .login:
            return "http://3.34.57.155:3000/api/v1/users/login"
        case .createTeam:
            return "http://3.34.57.155:3000/api/v1/teams"
        case .joinTeam:
            return "http://3.34.57.155:3000/api/v1/users/join-team"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .createTeam:
            return .post
        case .joinTeam:
            return .post
        }
    }
    
    var body: T? {
        switch self {
        case .login(let body):
            return body
        case .createTeam(let body, _):
            return body
        case .joinTeam(let body, _):
            return body
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .login:
            return nil
        case .createTeam(_, let userId):
            let headers = ["user_id": userId]
            return HTTPHeaders(headers)
        case .joinTeam(_, let userId):
            let headers = ["user_id": userId]
            return HTTPHeaders(headers)
        }
    }
}
