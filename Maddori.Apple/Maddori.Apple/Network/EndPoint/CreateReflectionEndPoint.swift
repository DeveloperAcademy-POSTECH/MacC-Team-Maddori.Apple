//
//  CreateReflectionEndPoint.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/19.
//

import Alamofire

enum CreateReflectionEndPoint<T: Encodable> {
    case patchReflectionDetail(reflectionId: Int, T)
    
    var address: String {
        switch self {
        case .patchReflectionDetail(let reflectionId, _):
            return "\(UrlLiteral.baseUrl)/teams/\(UserDefaultStorage.teamId)/reflections/\(reflectionId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .patchReflectionDetail:
            return .patch
        }
    }
    
    var body: T? {
        switch self {
        case .patchReflectionDetail(_, let body):
            return body
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        case .patchReflectionDetail:
            let headers = ["user_id": "\(UserDefaultStorage.userId)"]
            return HTTPHeaders(headers)
        }
    }
}

