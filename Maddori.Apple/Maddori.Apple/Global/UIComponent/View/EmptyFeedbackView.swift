//
//  EmptyFeedbackView.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/06.
//

import UIKit

import SnapKit

final class EmptyFeedbackView: UIView {
    
    // MARK: - property
    
    private let emptyFeedback = EmptyFeedbackLabel()
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .body3
        label.textColor = .gray700
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
        self.addSubview(emptyFeedback)
        emptyFeedback.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(88)
            $0.height.equalTo(54)
            $0.top.equalToSuperview().inset(2)
        }
        
        self.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(emptyFeedback.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
        }
    }
}
