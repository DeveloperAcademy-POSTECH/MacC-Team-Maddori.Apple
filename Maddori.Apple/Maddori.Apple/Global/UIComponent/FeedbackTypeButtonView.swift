//
//  FeedbackTypeButtonView.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

import SnapKit

final class FeedbackTypeButtonView: UIButton {
    private enum FeedbackType {
        case continueType
        case stopType
    }
    private enum Size {
        static let buttonPadding: CGFloat = 11
        static let width: CGFloat = 158
        static let height: CGFloat = 46
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - property
    
    private var selectedType: FeedbackType = .continueType
    private let continueShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white100
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = 10
        return view
    }()
    private let stopShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white100
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = 10
        return view
    }()
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white100, for: .normal)
        button.titleLabel?.font = .main
        button.backgroundColor = .blue200
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        let buttonAction = UIAction { [weak self] _ in
            self?.touchUpToSelectType(.continueType)
        }
        button.addAction(buttonAction, for: .touchUpInside)
        return button
    }()
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.setTitle("Stop", for: .normal)
        button.setTitleColor(.gray600, for: .normal)
        button.titleLabel?.font = .main
        button.backgroundColor = .white100
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        let buttonAction = UIAction { [weak self] _ in
            self?.touchUpToSelectType(.stopType)
        }
        button.addAction(buttonAction, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    private func render() {
        self.addSubview(continueShadowView)
        continueShadowView.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
        }
        continueShadowView.addSubview(continueButton)
        continueButton.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
        }

        self.addSubview(stopShadowView)
        stopShadowView.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
            $0.leading.equalTo(continueShadowView.snp.trailing).offset(11)
            $0.centerY.equalTo(continueShadowView)
        }
        stopShadowView.addSubview(stopButton)
        stopButton.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
            $0.leading.equalTo(continueButton.snp.trailing).offset(11)
            $0.centerY.equalTo(continueButton)
        }
    }
    
    // MARK: - function
    private func touchUpToSelectType(_ type: FeedbackType) {
        if type == .continueType {
            continueButton.setTitleColor(.white100, for: .normal)
            continueButton.backgroundColor = .blue200
            continueShadowView.layer.shadowRadius = 2
            stopButton.setTitleColor(.gray600, for: .normal)
            stopButton.backgroundColor = .white100
            stopShadowView.layer.shadowRadius = 1
            
            // FIXME: - 선택된 feedback 타입 전달
            
        } else {
            stopButton.setTitleColor(.white100, for: .normal)
            stopButton.backgroundColor = .blue200
            stopShadowView.layer.shadowRadius = 2
            continueButton.setTitleColor(.gray600, for: .normal)
            continueButton.backgroundColor = .white100
            continueShadowView.layer.shadowRadius = 1
            
            // FIXME: - 선택된 feedback 타입 전달
            
        }
    }
}
