//
//  TeamDetailMemberTableViewCell.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/03/17.
//

import UIKit

import SnapKit

final class TeamDetailMemberTableViewCell: BaseTableViewCell {
    
    private let memberInfoView = MemberInformationView()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(memberInfoView)
        memberInfoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    func setupLayoutInfoView(nickname: String, role: String, imagePath: String?) {
        memberInfoView.profileNicknameLabel.text = nickname
        memberInfoView.profileRoleLabel.text = role
        if let imagePath {
            memberInfoView.profileImageView.load(from: UrlLiteral.iamgeBaseUrl + imagePath)
        }
    }
}
