//
//  CreateReflectionEndPoint.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/19.
//

import Alamofire

enum CreateReflectionEndPoint<T: Encodable> {
    case patchReflectionDetail(reflectionId: Int, T)
    case deleteReflectionDetail(reflectionId: Int)
    
    var address: String {
        switch self {
        case .patchReflectionDetail(let reflectionId, _):
            return "\(Config.baseUrl)/teams/\(UserDefaultStorage.teamId)/reflections/\(reflectionId)"
        case .deleteReflectionDetail(let reflectionId):
            return "\(Config.baseUrl)/teams/\(UserDefaultStorage.teamId)/reflections/\(reflectionId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .patchReflectionDetail:
            return .patch
        case .deleteReflectionDetail:
            return .delete
        }
    }
    
    var body: T? {
        switch self {
        case .patchReflectionDetail(_, let body):
            return body
        case .deleteReflectionDetail(_):
            return nil
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        case .patchReflectionDetail:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
        case .deleteReflectionDetail:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
        }
    }
}

