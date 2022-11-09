//
//  FeedbackTypeButtonView.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

import SnapKit

final class FeedbackTypeButtonView: UIButton {
    var changeFeedbackType: ((FeedbackButtonType) -> ())?
    
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
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = SizeLiteral.componentCornerRadius
        return view
    }()
    private let stopShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white100
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = SizeLiteral.componentCornerRadius
        return view
    }()
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white100, for: .normal)
        button.titleLabel?.font = .main
        button.backgroundColor = .blue200
        button.clipsToBounds = true
        button.layer.cornerRadius = SizeLiteral.componentCornerRadius
        let action = UIAction { [weak self] _ in
            self?.touchUpToSelectType(FeedbackButtonType.continueType)
            self?.changeFeedbackType?(FeedbackButtonType.continueType)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.setTitle("Stop", for: .normal)
        button.setTitleColor(.gray600, for: .normal)
        button.titleLabel?.font = .main
        button.backgroundColor = .white100
        button.clipsToBounds = true
        button.layer.cornerRadius = SizeLiteral.componentCornerRadius
        let action = UIAction { [weak self] _ in
            self?.touchUpToSelectType(FeedbackButtonType.stopType)
            self?.changeFeedbackType?(FeedbackButtonType.stopType)
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
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
            $0.leading.top.equalToSuperview()
        }
        
        continueShadowView.addSubview(continueButton)
        continueButton.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
            $0.leading.equalTo(continueShadowView.snp.leading)
            $0.top.equalTo(continueShadowView.snp.top)
        }

        self.addSubview(stopShadowView)
        stopShadowView.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
            $0.leading.equalTo(continueShadowView.snp.trailing).offset(Size.buttonPadding)
            $0.centerY.equalTo(continueShadowView)
        }
        
        stopShadowView.addSubview(stopButton)
        stopButton.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
            $0.leading.equalTo(continueButton.snp.trailing).offset(Size.buttonPadding)
            $0.centerY.equalTo(continueButton)
        }
    }
    
    // MARK: - func
    
    func touchUpToSelectType(_ type: FeedbackButtonType) {
        switch type {
        case .continueType:
            continueButton.setTitleColor(.white100, for: .normal)
            continueButton.backgroundColor = .blue200
            stopButton.setTitleColor(.gray600, for: .normal)
            stopButton.backgroundColor = .white100
            // FIXME: - 선택된 feedback 타입 전달
        case .stopType:
            stopButton.setTitleColor(.white100, for: .normal)
            stopButton.backgroundColor = .blue200
            continueButton.setTitleColor(.gray600, for: .normal)
            continueButton.backgroundColor = .white100
            // FIXME: - 선택된 feedback 타입 전달
        }
    }
}
