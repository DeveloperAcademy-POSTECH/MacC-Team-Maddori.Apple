//
//  ProfileImageButton.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2023/01/21.
//

import UIKit

import SnapKit

final class ProfileImageButton: UIButton {
    
    // MARK: - property
    
    var profileImage = UIImageView(image: ImageLiterals.imgProfileNone)
    private let profilePlus: UIImageView = {
       let imageView = UIImageView()
        imageView.image = ImageLiterals.icPlus
        imageView.tintColor = .blue200
        return imageView
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(profileImage)
        profileImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.addSubview(profilePlus)
        profilePlus.snp.makeConstraints {
            $0.top.trailing.equalTo(profileImage)
            $0.width.equalTo(20)
            $0.height.equalTo(22)
        }
    }
}
