//
//  MyReflectionEndPoint.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/11/17.
//

import Alamofire

enum MyReflectionEndPoint<T: Encodable>: EndPointable {
    case fetchPastReflectionList(teamId: Int)
    case fetchCertainTypeFeedbackAllID(reflectionId: Int, cssType: FeedBackDTO)
    
    var address: String {
        switch self {
        case .fetchPastReflectionList(let teamId):
            return "\(UrlLiteral.baseUrl)/teams/\(teamId)/reflections"
        case .fetchCertainTypeFeedbackAllID(let reflectionId, let cssType):
            return "\(UrlLiteral.baseUrl)/teams/\(UserDefaultStorage.teamId)/reflections/\(reflectionId)/feedbacks?type=\(cssType.rawValue)"
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
        case .fetchPastReflectionList(_):
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
        case .fetchCertainTypeFeedbackAllID(_, _):
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
        }
    }
}
