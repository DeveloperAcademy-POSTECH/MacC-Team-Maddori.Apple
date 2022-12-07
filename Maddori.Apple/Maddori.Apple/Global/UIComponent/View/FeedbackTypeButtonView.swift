//
//  FeedbackTypeButtonView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/12/04.
//

import UIKit

import SnapKit

final class FeedbackTypeButtonView: UIView {
    var changeFeedbackType: ((FeedbackButtonType) -> ())?
    var feedbackType: FeedBackType? {
        didSet {
            guard let type = feedbackType else { return }
            applyFeedbackButtonStyle(type)
            applyButtonLabelStyle(type)
        }
    }
    
    // MARK: - property
    
    private let continueShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white100
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = .zero
        view.layer.cornerRadius = SizeLiteral.componentCornerRadius
        return view
    }()
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        let action = UIAction { [weak self] _ in
            self?.changeFeedbackType?(.continueType)
            self?.feedbackType = .continueType
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let continueTitleLabel: UILabel = {
        let label = UILabel()
        label.text = FeedBackType.continueType.rawValue
        label.font = .main
        return label
    }()
    private let continueSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackTypeButtonViewContinueSubTitle
        label.font = .body4
        label.textColor = .gray500
        return label
    }()
    private let stopShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white100
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = .zero
        view.layer.cornerRadius = SizeLiteral.componentCornerRadius
        return view
    }()
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        let action = UIAction { [weak self] _ in
            self?.changeFeedbackType?(.stopType)
            self?.feedbackType = .stopType
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let stopTitleLabel: UILabel = {
        let label = UILabel()
        label.text = FeedBackType.stopType.rawValue
        label.font = .main
        return label
    }()
    private let stopSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackTypeButtonViewStopSubTitle
        label.font = .body4
        label.textColor = .gray500
        return label
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if feedbackType == nil {
            applyFeedbackButtonStyle(.continueType)
            applyButtonLabelStyle(.continueType)
        }
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(continueShadowView)
        continueShadowView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.trailing.equalTo(self.snp.centerX).offset(-10)
            $0.height.equalTo(97)
        }
        
        self.addSubview(stopShadowView)
        stopShadowView.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.leading.equalTo(self.snp.centerX).offset(10)
            $0.height.equalTo(97)
        }
        
        continueShadowView.addSubview(continueButton)
        continueButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        continueButton.addSubview(continueTitleLabel)
        continueTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        continueButton.addSubview(continueSubTitleLabel)
        continueSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(continueTitleLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        stopShadowView.addSubview(stopButton)
        stopButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stopButton.addSubview(stopTitleLabel)
        stopTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        stopButton.addSubview(stopSubTitleLabel)
        stopSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(continueTitleLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    private func applyFeedbackButtonStyle(_ type: FeedBackType) {
        switch type {
        case .continueType:
            applyBorderStyle(selectedButton: continueButton, unselectedButton: stopButton)
        case .stopType:
            applyBorderStyle(selectedButton: stopButton, unselectedButton: continueButton)
        default:
            break
        }
    }
    
    private func applyBorderStyle(selectedButton: UIButton, unselectedButton: UIButton) {
        selectedButton.layer.borderWidth = 2
        selectedButton.layer.cornerRadius = SizeLiteral.componentCornerRadius
        selectedButton.layer.borderColor = UIColor.blue200.cgColor
        unselectedButton.layer.borderWidth = 0
        unselectedButton.layer.borderColor = UIColor.clear.cgColor
        unselectedButton.makeShadow(color: .black, opacity: 0.15, offset: .zero, radius: 1)
    }
    
    private func applyButtonLabelStyle(_ type: FeedBackType) {
        switch type {
        case .continueType:
            continueTitleLabel.textColor = .blue200
            continueSubTitleLabel.textColor = .blue200
            stopTitleLabel.textColor = .black100
            stopSubTitleLabel.textColor = .gray500
        case .stopType:
            stopTitleLabel.textColor = .blue200
            stopSubTitleLabel.textColor = .blue200
            continueTitleLabel.textColor = .black100
            continueSubTitleLabel.textColor = .gray500
        default:
            break
        }
    }
}
