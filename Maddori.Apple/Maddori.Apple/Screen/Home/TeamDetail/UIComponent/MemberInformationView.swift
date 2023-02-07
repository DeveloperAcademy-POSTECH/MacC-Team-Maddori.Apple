//
//  MemberInformationView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/02/07.
//

import UIKit

import SnapKit

final class MemberInformationView: UIView {
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 23
        imageView.image = ImageLiterals.imgPersonTab
        return imageView
    }()
    private let profileNicknameLabel: UILabel = {
        let label = UILabel()
        // FIXME: - API 연결 후 삭제
        label.text = "이두"
        label.font = .label2
        label.textColor = .gray600
        return label
    }()
    private let profileRoleLabel: UILabel = {
        let label = UILabel()
        // FIXME: - API 연결 후 삭제
        label.text = "디자인 리드 / 개발자"
        label.font = .caption2
        label.textColor = .gray400
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
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
