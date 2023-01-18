//
//  JoinReflectionButton.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/21.
//

import UIKit

import SnapKit

final class JoinReflectionButton: UIView {
    
    var reflectionStatus: ReflectionStatus
    var reflectionTitle: String
    var reflectionDate: Date
    
    var buttonAction: (() -> ())?
    
    // MARK: - property
    
    private let joinButton = UIButton()
    private lazy var reflectionTitleLabel: UILabel = {
        let label = UILabel()
        switch reflectionStatus {
        case .SettingRequired, .Done:
            label.text = TextLiteral.reflectionTitleLabelSettingRequired
            label.textColor = .gray600
        case .Before:
            label.text = reflectionTitle
            label.textColor = .gray600
        case .Progressing:
            label.text = TextLiteral.reflectionTitleLabelProgressing
            label.textColor = .white100
        }
        label.font = .label2
        return label
    }()
    private lazy var reflectionDescriptionLabel: UILabel = {
        let label = UILabel()
        switch reflectionStatus {
        case .SettingRequired, .Done:
            label.text = TextLiteral.reflectionDescriptionLabelSettingRequired
            label.textColor = .gray500
        case .Before:
            label.text = reflectionDate.description.formatDateString(to: "M월 d일 (EEE) HH:mm")
            label.textColor = .gray500
        case .Progressing:
            label.text = TextLiteral.reflectionDescriptionLabelProgressing
            label.textColor = .white100
        }
        label.font = .caption3
        return label
    }()
    private lazy var calendarImageView: UIImageView = {
        let imageView = UIImageView()
        switch reflectionStatus {
        case .SettingRequired, .Done:
            imageView.image = ImageLiterals.imgEmptyCalendar
        case .Before:
            imageView.image = ImageLiterals.imgCalendar
        case .Progressing:
            imageView.image = ImageLiterals.imgYellowCalendar
        }
        return imageView
    }()
    
    // MARK: - life cycle
    
    init(reflectionStatus: ReflectionStatus, title: String, date: Date) {
        self.reflectionStatus = reflectionStatus
        self.reflectionTitle = title
        self.reflectionDate = date
        super.init(frame: .zero)
        render()
        setupJoinButtonAction()
    }
    
    required init?(coder: NSCoder) { nil }
    
    func render() {
        self.addSubview(joinButton)
        joinButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        joinButton.addSubview(reflectionTitleLabel)
        reflectionTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.top.equalToSuperview().inset(18)
        }
        
        joinButton.addSubview(reflectionDescriptionLabel)
        reflectionDescriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.top.equalTo(reflectionTitleLabel.snp.bottom).offset(6)
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
