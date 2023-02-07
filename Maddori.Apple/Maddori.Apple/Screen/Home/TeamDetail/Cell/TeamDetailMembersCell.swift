//
//  TeamDetailMembersCell.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/02/02.
//

import UIKit

import SnapKit

final class TeamDetailMembersCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    private let memberInformationView = MemberInformationView()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(memberInformationView)
    }
}
