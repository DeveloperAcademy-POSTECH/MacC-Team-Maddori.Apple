//
//  MyFeedBackEndPoint.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/17.
//

import Alamofire

enum MyFeedBackEndPoint<T: Encodable> {
    case fetchCurrentTeamMember
    case fetchCertainMemberFeedBack(teamId: Int, memberId: Int, userId: Int)
    case deleteFeedBack(teamId: Int, reflectionId: Int, feedBackId: Int, userId: Int)
    case putEditFeedBack(teamId: Int, reflectionId: Int, feedBackId: Int, T, userId: Int)
    
    var address: String {
        switch self {
        case .fetchCurrentTeamMember:
            return "\(UrlLiteral.baseUrl)/teams/\(UserDefaultStorage.teamId)/members"
        case .fetchCertainMemberFeedBack(let teamId, let memberId, _):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)/reflections/current/feedbacks/from-me?members=\(memberId)"
        case .deleteFeedBack(let teamId, let reflectionId, let feedBackId, _):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)/reflections/\(reflectionId)/feedbacks/\(feedBackId)"
        case .putEditFeedBack(let teamId, let reflectionId, let feedBackId, _, _):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)/reflections/\(reflectionId)/feedbacks/\(feedBackId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchCurrentTeamMember:
            return .get
        case .fetchCertainMemberFeedBack:
            return .get
        case .deleteFeedBack:
            return .delete
        case .putEditFeedBack:
            return .put
        }
    }
    
    var body: T? {
        switch self {
        case .fetchCurrentTeamMember:
            return nil
        case .fetchCertainMemberFeedBack:
            return nil
        case .deleteFeedBack:
            return nil
        case .putEditFeedBack(_, _, _, let body, _):
            return body
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .fetchCurrentTeamMember:
            let headers = ["user_id": "\(UserDefaultStorage.userId)"]
            return HTTPHeaders(headers)
        case .fetchCertainMemberFeedBack(_, _, let userId):
            let headers = ["user_id": "\(userId)"]
            return HTTPHeaders(headers)
        case .deleteFeedBack(_, _, _, let userId):
            let headers = ["user_id": "\(userId)"]
            return HTTPHeaders(headers)
        case .putEditFeedBack(_, _, _, _, let userId):
            let headers = ["user_id": "\(userId)"]
            return HTTPHeaders(headers)
        }
    }
}
