//
//  KeywordView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/12/06.
//

import UIKit

import SnapKit

final class FeedbackKeyword: UIView {
    let keywordType: KeywordType = .previewKeyword
    let title: String
    
    // MARK: - property
    
    private lazy var feedbackLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.textColor = keywordType.textColor
        label.font = .main
        return label
    }()
    
    // MARK: - life cycle
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func configUI() {
        self.backgroundColor = keywordType.labelColor[0]
        self.layer.cornerRadius = 24
        self.layer.maskedCorners = keywordType.maskedCorners
        self.makeShadow(color: .black,
                        opacity: keywordType.shadowOpacity,
                        offset: .zero,
                        radius: keywordType.shadowRadius)
    }
    
    private func render() {
        self.addSubview(feedbackLabel)
        feedbackLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(13)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}

