//
//  MyFeedBackEndPoint.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/17.
//

import Alamofire

enum MyFeedBackEndPoint {
    case fetchCurrentTeamMember(teamId: Int, userId: Int)
    case fetchCertainMemberFeedBack(teamId: Int, memberId: Int, userId: Int)
    
    var address: String {
        switch self {
        case .fetchCurrentTeamMember(let teamId, _):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)/members"
        case .fetchCertainMemberFeedBack(let teamId, let memberId, _):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)/reflections/current/feedbacks/from-me?members=\(memberId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchCurrentTeamMember:
            return .get
        case .fetchCertainMemberFeedBack:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .fetchCurrentTeamMember(_, let userId):
            let headers = ["user_id": "\(userId)"]
            return HTTPHeaders(headers)
        case .fetchCertainMemberFeedBack(_, _, let userId):
            let headers = ["user_id": "\(userId)"]
            return HTTPHeaders(headers)
        }
    }
}
