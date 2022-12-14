//
//  JoinReflectionButton.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/21.
//

import UIKit

import SnapKit

final class JoinReflectionButton: UIView {
    
    var buttonAction: (() -> ())?
    
    // MARK: - property
    
    private let joinButton = UIButton()
    private let reflectionStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .label2
        label.text = TextLiteral.joinReflectionButtonStatusText
        label.textColor = .white100
        return label
    }()
    private let touchToEnterLabel: UILabel = {
        let label = UILabel()
        label.font = .caption3
        label.text = TextLiteral.joinReflectionTouchToEnterLabel
        label.textColor = .white100
        return label
    }()
    private let calendarImageView = UIImageView(image: ImageLiterals.imgYellowCalendar)
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        setupJoinButtonAction()
    }

    required init?(coder: NSCoder) { nil }
    
    func render() {
        self.addSubview(joinButton)
        joinButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        joinButton.addSubview(reflectionStatusLabel)
        reflectionStatusLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.top.equalToSuperview().inset(18)
        }
        
        joinButton.addSubview(touchToEnterLabel)
        touchToEnterLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.top.equalTo(reflectionStatusLabel.snp.bottom).offset(6)
        }
        
        joinButton.addSubview(calendarImageView)
        calendarImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18)
            $0.verticalEdges.equalToSuperview().inset(16)
            $0.width.equalTo(37)
            $0.height.equalTo(39)
        }
    }
    
    // MARK: - func
    
    private func setupJoinButtonAction() {
        let action = UIAction { [weak self] _ in
            self?.buttonAction?()
        }
        joinButton.addAction(action, for: .touchUpInside)
    }
}
