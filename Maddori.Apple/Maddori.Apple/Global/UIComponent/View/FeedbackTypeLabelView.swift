//
//  FeedbackTypeLabelView.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/11/02.
//

import UIKit

import SnapKit

final class FeedbackTypeLabelView: UILabel {
    private enum Size {
        static let width: CGFloat = 158
        static let height: CGFloat = 46
        static let labelPadding: CGFloat = UIScreen.main.bounds.width - SizeLiteral.leadingTrailingPadding * 2 - Size.width * 2
    }
    var feedbackType: FeedBackType = .continueType {
        didSet { setupAttribute(feedbackType) }
    }
    
    // MARK: - property
    
    private let continueShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white100
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = SizeLiteral.componentCornerRadius
        return view
    }()
    private let stopShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white100
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = SizeLiteral.componentCornerRadius
        return view
    }()
    private lazy var continueLabel: UILabel = {
        let label = UILabel()
        label.text = "Continue"
        label.font = .main
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = SizeLiteral.componentCornerRadius
        return label
    }()
    private lazy var stopLabel: UILabel = {
        let label = UILabel()
        label.text = "Stop"
        label.font = .main
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = SizeLiteral.componentCornerRadius
        return label
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
        
        continueShadowView.addSubview(continueLabel)
        continueLabel.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
            $0.leading.equalTo(continueShadowView.snp.leading)
            $0.top.equalTo(continueShadowView.snp.top)
        }

        self.addSubview(stopShadowView)
        stopShadowView.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
            $0.leading.equalTo(continueShadowView.snp.trailing).offset(Size.labelPadding)
            $0.centerY.equalTo(continueShadowView)
        }
        
        stopShadowView.addSubview(stopLabel)
        stopLabel.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
            $0.leading.equalTo(continueLabel.snp.trailing).offset(Size.labelPadding)
            $0.centerY.equalTo(continueLabel)
        }
    }
    
    // MARK: - func
    
    private func setupAttribute(_ type: FeedBackType) {
        switch type {
        case .continueType:
            continueLabel.textColor = .white100
            continueLabel.backgroundColor = .blue200
            continueShadowView.layer.shadowRadius = 2
            stopLabel.textColor = .gray300
            stopLabel.backgroundColor = .white100
            stopShadowView.layer.shadowRadius = 1
        case .stopType:
            stopLabel.textColor = .white100
            stopLabel.backgroundColor = .blue200
            stopShadowView.layer.shadowRadius = 2
            continueLabel.textColor = .gray300
            continueLabel.backgroundColor = .white100
            continueShadowView.layer.shadowRadius = 1
        }
    }
}

