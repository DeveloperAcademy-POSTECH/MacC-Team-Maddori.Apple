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
    case deleteLeaveTeam
    case fetchTeams
    
    var address: String {
        switch self {
        case .fetchTeamMember:
            return "\(UrlLiteral.baseUrl2)/teams/\(UserDefaultStorage.teamId)/members"
            
        case .fetchTeamInformation:
            return "\(UrlLiteral.baseUrl2)/teams/\(UserDefaultStorage.teamId)"
            
        case .deleteLeaveTeam:
            return "\(UrlLiteral.baseUrl2)/users/team/\(UserDefaultStorage.teamId)/leave"
            
        case .fetchTeams:
            return "\(UrlLiteral.baseUrl2)/users/teams"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchTeamMember:
            return .get
            
        case .fetchTeamInformation:
            return .get
            
        case .deleteLeaveTeam:
            return .delete
            
        case .fetchTeams:
            return .get
        }
    }
    
    var body: T? {
        switch self {
        case .fetchTeamMember:
            return nil
            
        case .fetchTeamInformation:
            return nil
            
        case .deleteLeaveTeam:
            return nil
            
        case .fetchTeams:
            return nil
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
            
        case .deleteLeaveTeam:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
            
        case .fetchTeams:
            let headers = [
                "access_token": "\(UserDefaultStorage.accessToken)",
                "refresh_token": "\(UserDefaultStorage.refreshToken)"
            ]
            return HTTPHeaders(headers)
        }
    }
}
