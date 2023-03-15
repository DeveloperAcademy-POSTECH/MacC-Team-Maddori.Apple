//
//  MyBoxMemberCollectionViewCell.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/02.
//

import UIKit

import SnapKit

final class MyFeedbackMemberCollectionViewCell: BaseCollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                setSelectedCellLayer()
            } else {
                setShadowLayer()
            }
        }
    }
    
    // MARK: - property
    
    private let shadowView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.backgroundColor = .white
        view.makeShadow(color: .black, opacity: 0.25, offset: CGSize.zero, radius: 1)
        return view
    }()
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    private let memberNameLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .gray400
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        setShadowLayer()
    }
    
    override func render() {
        self.addSubview(shadowView)
        shadowView.snp.makeConstraints {
            $0.centerX.top.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        
        shadowView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.addSubview(memberNameLabel)
        memberNameLabel.snp.makeConstraints {
            $0.top.equalTo(shadowView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
    }
    
    // MARK: - func
    
    private func setSelectedCellLayer() {
        shadowView.layer.cornerRadius = 30
        shadowView.layer.borderColor = UIColor.blue200.cgColor
        shadowView.layer.borderWidth = 2
        shadowView.layer.shadowOpacity = 0
        memberNameLabel.textColor = .blue200
    }
    
    private func setShadowLayer() {
        shadowView.layer.cornerRadius = 30
        shadowView.layer.borderWidth = 0
        shadowView.layer.borderColor = UIColor.clear.cgColor
        shadowView.makeShadow(color: .black, opacity: 0.25, offset: CGSize.zero, radius: 1)
        memberNameLabel.textColor = .gray400
    }
    
    func setMemberName(name: String) {
        memberNameLabel.text = name
    }
    
    func setMemberProfileImage(from path: String?) {
        if let path = path {
            let fullImagePath = UrlLiteral.iamgeBaseUrl + path
            profileImageView.load(from: fullImagePath)
            
        } else {
            profileImageView.image = ImageLiterals.imgProfileNone
        }
    }
}
