//
//  EmptyFeedbackView.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/06.
//

import UIKit

import SnapKit

final class EmptyFeedbackView: BaseCollectionViewCell {
    
    private enum Size {
        static let capsuleWidth: CGFloat = 88
        static let capsuleHeight: CGFloat = 54
        static let capsuleYOffset: CGFloat = 20
        static let labelYOffset: CGFloat = 25
    }
    
    // MARK: - property
    
    private let emptyFeedbackCapsule = EmptyFeedbackLabel()
    lazy var emptyFeedbackLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .body3
        label.textColor = .gray700
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(emptyFeedbackCapsule)
        emptyFeedbackCapsule.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-Size.capsuleYOffset)
            $0.width.equalTo(Size.capsuleWidth)
            $0.height.equalTo(Size.capsuleHeight)
        }
        
        self.addSubview(emptyFeedbackLabel)
        emptyFeedbackLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emptyFeedbackCapsule.snp.bottom).offset(20)
        }
    }
}
