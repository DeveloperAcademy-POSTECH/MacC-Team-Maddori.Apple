//
//  TeamDetailMemberTableViewCell.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/03/17.
//

import UIKit

import SnapKit

final class TeamDetailMemberTableViewCell: BaseTableViewCell {
    
    // MARK: - property
    
    private let memberInfoView = MemberInformationView(nickname: "nickname test", role: "role test")
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(memberInfoView)
        memberInfoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
