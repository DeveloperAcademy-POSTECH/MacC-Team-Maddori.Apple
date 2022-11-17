//
//  AddFeedBackEndPoint.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/17.
//

import Foundation

import Alamofire

enum AddFeedBackEndPoint<T: Encodable> {
    case fetchCurrentTeamMember(teamId: String, userId: String)
    
    var address: String {
        switch self {
        case .fetchCurrentTeamMember(let teamId, _):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)/members"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchCurrentTeamMember:
            return .get
        }
    }
    
    var body: T? {
        switch self {
        case .fetchCurrentTeamMember:
            return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .fetchCurrentTeamMember(_, let userId):
            let header = ["user_id": userId]
            return HTTPHeaders(header)
        }
    }
}
