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
            setupFeedbackButtonStyle(feedbackType ?? .continueType)
        }
    }
    private enum Size {
        static let width: CGFloat = 158
        static let height: CGFloat = 46
        static let buttonPadding: CGFloat = UIScreen.main.bounds.width - SizeLiteral.leadingTrailingPadding * 2 - Size.width * 2
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
            self?.setupFeedbackButtonStyle(.continueType)
        }
        button.addAction(action, for: .touchUpInside)
        return button
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
            self?.setupFeedbackButtonStyle(.stopType)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        stopShadowView.addSubview(stopButton)
        stopButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    private func setupFeedbackButtonStyle(_ type: FeedBackType) {
        switch type {
        case .continueType:
            continueButton.layer.borderWidth = 2
            continueButton.layer.cornerRadius = 10
            continueButton.layer.borderColor = UIColor.blue200.cgColor
            stopButton.layer.borderWidth = 0
            stopButton.layer.borderColor = UIColor.clear.cgColor
            stopButton.makeShadow(color: .black, opacity: 0.15, offset: .zero, radius: 3)
        case .stopType:
            stopButton.layer.borderWidth = 2
            stopButton.layer.cornerRadius = 10
            stopButton.layer.borderColor = UIColor.blue200.cgColor
            continueButton.layer.borderWidth = 0
            continueButton.layer.borderColor = UIColor.clear.cgColor
            continueButton.makeShadow(color: .black, opacity: 0.15, offset: .zero, radius: 1)
        default:
            break
        }
    }
}
