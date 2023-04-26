//
//  TeamDetailEndPoint.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/03/30.
//

import Alamofire

enum TeamDetailEndPoint<T: Encodable>: EndPointable {
    case fetchTeamMember
    case fetchTeamInformation
    case deleteTeam
    case fetchUserTeamList
    case putEditProfile(T)
    
    var address: String {
        switch self {
        case .fetchTeamMember:
            return "\(UrlLiteral.baseUrl2)/teams/\(UserDefaultStorage.teamId)/members"
            
        case .fetchTeamInformation:
            return "\(UrlLiteral.baseUrl2)/teams/\(UserDefaultStorage.teamId)"
            
        case .deleteTeam:
            return "\(UrlLiteral.baseUrl2)/users/team/\(UserDefaultStorage.teamId)/leave"
            
        case .fetchUserTeamList:
            return "\(UrlLiteral.baseUrl2)/users/teams"
            
        case .putEditProfile:
            return "\(UrlLiteral.baseUrl2)/users/teams/\(UserDefaultStorage.teamId)/profile"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchTeamMember:
            return .get
            
        case .fetchTeamInformation:
            return .get
            
        case .deleteTeam:
            return .delete
            
        case .fetchUserTeamList:
            return .get
            
        case .putEditProfile:
            return .put
        }
    }
    
    var body: T? {
        switch self {
        case .fetchTeamMember:
            return nil
            
        case .fetchTeamInformation:
            return nil
            
        case .deleteTeam:
            return nil
            
        case .fetchUserTeamList:
            return nil
            
        case .putEditProfile(let body):
            return body
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .fetchTeamMember:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
            
        case .fetchTeamInformation:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
            
        case .deleteTeam:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
            
        case .fetchUserTeamList:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
            
        case .putEditProfile:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)",
                "Content-Type": "multipart/form-data"
            ]
            return HTTPHeaders(headers)
        }
    }
}
