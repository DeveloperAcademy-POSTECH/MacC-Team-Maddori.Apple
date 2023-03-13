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
    
    let joinButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    private lazy var reflectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .label2
        return label
    }()
    private let reflectionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .caption3
        return label
    }()
    private let calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.shadowColor = UIColor.black100.cgColor
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowRadius = 2
        imageView.layer.shadowOpacity = 0.1
        return imageView
    }()
    
    // MARK: - life cycle
    
    init() {
        super.init(frame: .zero)
        render()
        configUI()
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
    
    private func configUI() {
        self.makeShadow(color: .black100, opacity: 0.2, offset: .zero, radius: 2)
    }
    
    private func setupJoinButtonAction() {
        let action = UIAction { [weak self] _ in
            self?.buttonAction?()
        }
        joinButton.addAction(action, for: .touchUpInside)
    }
    
    func setupAttribute(reflectionStatus: ReflectionStatus, title: String, date: String, isPreview: Bool) {
        if !isPreview {
            switch reflectionStatus {
            case .SettingRequired, .Done:
                reflectionTitleLabel.text = TextLiteral.reflectionTitleLabelSettingRequired
                reflectionTitleLabel.textColor = .gray600
                reflectionDescriptionLabel.text = TextLiteral.reflectionDescriptionLabelSettingRequired
                reflectionDescriptionLabel.textColor = .gray500
                calendarImageView.image = ImageLiterals.imgEmptyCalendar
            case .Before:
                reflectionTitleLabel.text = title
                reflectionTitleLabel.textColor = .gray600
                reflectionDescriptionLabel.text = date.formatDateString(to: "M월 d일 (EEE) HH:mm")
                reflectionDescriptionLabel.textColor = .gray500
                calendarImageView.image = ImageLiterals.imgCalendar
            case .Progressing:
                reflectionTitleLabel.text = TextLiteral.reflectionTitleLabelProgressing
                reflectionTitleLabel.textColor = .white100
                reflectionDescriptionLabel.text = TextLiteral.reflectionDescriptionLabelProgressing
                reflectionDescriptionLabel.textColor = .white100
                calendarImageView.image = ImageLiterals.imgYellowCalendar
            }
        } else {
            reflectionTitleLabel.text = TextLiteral.previewTitleLabel
            reflectionTitleLabel.textColor = .gray600
            reflectionDescriptionLabel.text = TextLiteral.previewDescriptionLabel
            reflectionDescriptionLabel.textColor = .gray500
            calendarImageView.image = ImageLiterals.imgEmptyCalendar
        }
    }
}
