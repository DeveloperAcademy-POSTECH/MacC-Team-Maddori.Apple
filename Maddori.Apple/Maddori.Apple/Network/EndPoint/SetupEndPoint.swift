//
//  SetupEndPoint.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Alamofire

enum SetupEndPoint<T: Encodable> {
    case login(T)
    case createTeam(T, header: String)
    
    var address: String {
        switch self {
        case .login:
            return "http://3.34.57.155:3000/api/v1/users/login"
        case .createTeam:
            return "http://3.34.57.155:3000/api/v1/teams"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .createTeam:
            return .post
        }
    }
    
    var body: T? {
        switch self {
        case .login(let body):
            return body
        case .createTeam(let body, _):
            return body
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .login:
            return nil
        case .createTeam(_, let header):
            let headers = ["user_id": header]
            return HTTPHeaders(headers)
        }
    }
}
