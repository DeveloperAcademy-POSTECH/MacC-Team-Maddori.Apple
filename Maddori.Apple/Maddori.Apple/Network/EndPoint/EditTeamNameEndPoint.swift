//
//  EditTeamNameEndPoint.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/04/11.
//

import Alamofire

enum EditTeamNameEndPoint<T: Encodable>: EndPointable {
    case patchEditTeamName(T)
    
    var address: String {
        switch self {
        case .patchEditTeamName:
            return "\(Config.baseUrl)/teams/\(UserDefaultStorage.teamId)/team-name"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .patchEditTeamName:
            return .patch
        }
    }
    
    var body: T? {
        switch self {
        case .patchEditTeamName(let body):
            return body
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .patchEditTeamName:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
        }
    }
}
