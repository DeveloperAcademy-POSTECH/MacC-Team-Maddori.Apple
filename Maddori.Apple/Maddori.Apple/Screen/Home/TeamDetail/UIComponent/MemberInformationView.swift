//
//  MemberInformationView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/02/07.
//

import UIKit

import SnapKit

final class MemberInformationView: UIView {
    
    // MARK: - property
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 23
        imageView.clipsToBounds = true
        imageView.image = ImageLiterals.imgProfileNone
        return imageView
    }()
    let profileNicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .label2
        label.textColor = .gray600
        return label
    }()
    let profileRoleLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.textColor = .gray400
        return label
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
