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
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.icPersonCircle
        imageView.layer.cornerRadius = 23
        return imageView
    }()
    
    override func render() {
        self.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(46)
        }
    }
}
