//
//  MyReflectionEndPoint.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/11/17.
//

import Alamofire

enum MyReflectionEndPoint<T: Encodable> {
    case fetchPastReflectionList(userId: Int)
    
    var address: String {
        switch self {
        case .fetchPastReflectionList(let teamId):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)/reflections"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchPastReflectionList:
            return .get
        }
    }
    
    var body: T? {
        switch self {
        case .fetchPastReflectionList:
            return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .fetchPastReflectionList(let userId):
            let headers = ["user_id": "\(userId)"]
            return HTTPHeaders(headers)
        }
    }
}
