//
//  MyReflectionEndPoint.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/11/17.
//

import Alamofire

enum MyReflectionEndPoint<T: Encodable> {
    case fetchPastReflectionList(teamId: Int ,userId: Int)
    case fetchCertainTypeFeedbackAllID(teamId:Int, userId: Int, reflectionId: Int, cssType: String)
    
    var address: String {
        switch self {
        case .fetchPastReflectionList(let teamId, _):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)/reflections"
        case .fetchCertainTypeFeedbackAllID(let teamId, _, let reflectionId, _):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)/reflections/\(reflectionId)/feedbacks"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchPastReflectionList:
            return .get
        case .fetchCertainTypeFeedbackAllID:
            return .get
        }
    }
    
    var body: T? {
        switch self {
        case .fetchPastReflectionList:
            return nil
        case .fetchCertainTypeFeedbackAllID:
            return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .fetchPastReflectionList(_, let userId):
            let headers = ["user_id": "\(userId)"]
            return HTTPHeaders(headers)
        case .fetchCertainTypeFeedbackAllID(_, let userId, _, _):
            let headers = ["user_id": "\(userId)"]
            return HTTPHeaders(headers)
        }
    }
}
