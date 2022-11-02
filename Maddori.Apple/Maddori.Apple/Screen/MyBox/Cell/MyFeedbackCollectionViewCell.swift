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
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
