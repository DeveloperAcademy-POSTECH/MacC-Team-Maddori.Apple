//
//  MyFeedbackCollectionViewCell.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/02.
//

import UIKit

import SnapKit

final class MyFeedbackCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.font = .label1
        label.textColor = .black100
        return label
    }()
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "너무 좋아요 ~ 너무 좋아요 ~ 너무 좋아요 ~ 너무 좋아요 ~ 너무 좋아요 ~ 너무 좋아요 ~ 너무 좋아요 ~ 너무 좋아요 ~ "
        label.font = .body2
        label.textColor = .gray400
        label.numberOfLines = 2
        
        return label
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        backgroundColor = .backgroundWhite
    }
    
    override func render() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        self.addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(66)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
}
