//
//  FeedbackTypeButtonView.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

import SnapKit

final class FeebackTypeButtonView: UIView {
    private enum Size {
        static let width: CGFloat = (UIScreen.main.bounds.width - (SizeLiteral.leadingTrailingPadding * 2) - 11) / 2
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
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white100, for: .normal)
        button.titleLabel?.font = .main
        button.backgroundColor = .blue200
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    private let stopButton: UIButton = {
        let button = UIButton()
        button.setTitle("Stop", for: .normal)
        button.setTitleColor(.white100, for: .normal)
        button.titleLabel?.font = .main
        button.backgroundColor = .blue200
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - life cycle
    
    private func render() {
        self.addSubview(continueButton)
        continueButton.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
        }
        
        self.addSubview(stopButton)
        stopButton.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
            $0.leading.equalTo(continueButton.snp.trailing).offset(11)
            $0.centerY.equalTo(continueButton)
        }
    }
}
