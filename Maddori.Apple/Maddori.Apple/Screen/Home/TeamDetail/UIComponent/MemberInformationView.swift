//
//  MemberInformationView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/02/07.
//

import UIKit

import SnapKit

final class MemberInformationView: UIView {
    let nickname: String
    let role: String
    
    // MARK: - property
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 23
        imageView.image = ImageLiterals.imgProfileNone
        return imageView
    }()
    private lazy var profileNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = nickname
        label.font = .label2
        label.textColor = .gray600
        return label
    }()
    private lazy var profileRoleLabel: UILabel = {
        let label = UILabel()
        label.text = role
        label.font = .caption2
        label.textColor = .gray400
        return label
    }()
    
    // MARK: - life cycle
    
    init(nickname: String, role: String) {
        self.nickname = nickname
        self.role = role
        super.init(frame: .zero)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - func
    
    private func render() {
        self.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(46)
        }
        
        self.addSubview(profileNicknameLabel)
        profileNicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
            $0.top.equalTo(profileImageView.snp.top).offset(8)
        }
        
        self.addSubview(profileRoleLabel)
        profileRoleLabel.snp.makeConstraints {
            $0.leading.equalTo(profileNicknameLabel.snp.leading)
            $0.top.equalTo(profileNicknameLabel.snp.bottom).offset(4)
        }
    }
}
