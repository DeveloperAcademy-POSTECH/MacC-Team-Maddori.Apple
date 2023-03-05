//
//  ReflectionMemberCollectionViewCell.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2023/02/06.
//

import UIKit

import SnapKit

final class ReflectionMemberCollectionViewCell: BaseCollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            applyAttribute()
        }
    }
    
    // MARK: - property
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.imgProfileNone
        imageView.layer.cornerRadius = 23
        return imageView
    }()
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray600
        label.font = .label2
        return label
    }()
    let roleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray400
        label.font = .caption2
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(profileImage)
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(46)
        }
        
        self.addSubview(nicknameLabel)
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(roleLabel)
        roleLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func configUI() {
        self.backgroundColor = .white300
        self.layer.cornerRadius = 8
        self.makeShadow(color: .black, opacity: 0.2, offset: CGSize.zero, radius: 2)
    }
    
    // MARK: - func
    
    func applyAttribute() {
        self.backgroundColor = .white100
        self.profileImage.layer.opacity = 0.5
        self.nicknameLabel.textColor = .gray300
        self.roleLabel.textColor = .gray300
        self.makeShadow(color: .black, opacity: 0.2, offset: CGSize.zero, radius: 1)
    }
}
