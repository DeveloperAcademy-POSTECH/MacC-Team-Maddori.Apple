//
//  StartSuggestionView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/23.
//

import UIKit

import SnapKit

final class StartSuggestionView: UIStackView {
        
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.startSuggestionViewStartText
        label.textColor = .gray600
        label.font = .label2
        return label
    }()
    private let startInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray600
        label.font = .body2
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - life cycle
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func render() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalToSuperview().inset(16)
        }
        
        self.addSubview(startInfoLabel)
        startInfoLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.bottom.equalToSuperview().inset(22)
        }
    }
    
    func setStartInfoLabel(info: String) {
        startInfoLabel.text = info
        startInfoLabel.setTextWithLineHeight(text: startInfoLabel.text, lineHeight: 22)
    }
}
