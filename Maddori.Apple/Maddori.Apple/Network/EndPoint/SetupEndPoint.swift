//
//  SetupEndPoint.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/16.
//

import Alamofire

enum SetupEndPoint<T: Encodable> {
    case login(T)
    
    var address: String {
        switch self {
        case .login:
            return "http://3.34.57.155:3000/api/v1/users/login"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    var body: T? {
        switch self {
        case .login(let body):
            return body
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .login:
            return nil
        }
    }
}
