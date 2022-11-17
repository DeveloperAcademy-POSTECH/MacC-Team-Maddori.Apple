//
//  MyFeedBackEndPoint.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/17.
//

import Alamofire

enum MyFeedBackEndPoint {
    case fetchCurrentTeamMember(teamId: Int, userId: Int)
    
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
    
    var headers: HTTPHeaders? {
        switch self {
        case .fetchCurrentTeamMember(_, let userId):
            let headers = ["user_id": "\(userId)"]
            return HTTPHeaders(headers)
        }
    }
}
