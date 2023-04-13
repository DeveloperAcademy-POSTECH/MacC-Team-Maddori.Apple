//
//  MemberCollectionViewCell.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

import SnapKit

final class MemberCollectionViewCell: BaseCollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                applyAttribute()
            } else {
                resetAttribute()
            }
        }
    }
    
    // MARK: - property
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
            memberInfoView.profileImageView.load(from: UrlLiteral.imageBaseURL + imagePath)
        }
    }
    
    private func applyAttribute() {
        if isSelected {
            memberInfoView.profileNicknameLabel.textColor = .blue200
            memberInfoView.profileRoleLabel.textColor = .blue200
        }
    }
    
    private func resetAttribute() {
        memberInfoView.profileNicknameLabel.textColor = .black
        memberInfoView.profileRoleLabel.textColor = .black
    }
}
