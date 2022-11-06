//
//  AlertView.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/11/06.
//

import UIKit

import SnapKit

enum AlertType: String {
    case delete = "삭제하기"
    case join = "합류하기"
}

final class AlertView: UIView {
    private enum Size {
        static let alertViewWidth: CGFloat = 265
        static let alertViewHeight: CGFloat = 163
        static let dividerWeight: CGFloat = 0.5
        static let buttonMinimumSize: CGFloat = 44
    }
    
    var title: String? {
        didSet { setupAttribute() }
    }
    
    var subTitle: String? {
        didSet { setupAttribute() }
    }
    
    var alertType: AlertType? {
        didSet { setupAttribute() }
    }
    
    
    // MARK: - property
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black100
        view.layer.opacity = 0.65
        return view
    }()
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white100
        view.layer.cornerRadius = 10
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue200
        label.font = .main
        return label
    }()
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray400
        label.font = .caption1
        return label
    }()
    private let labelButtonDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray300
        return view
    }()
    private let buttonIntervalDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray300
        return view
    }()
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.gray500, for: .normal)
        button.titleLabel?.textAlignment = .center
        // action 추가
        return button
    }()
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .center
        // action 추가
        return button
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundView.addSubview(alertView)
        alertView.snp.makeConstraints {
            $0.width.equalTo(Size.alertViewWidth)
            $0.height.equalTo(Size.alertViewHeight)
            $0.center.equalTo(backgroundView.snp.center)
        }
        
        alertView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(alertView.snp.top).inset(43)
            $0.centerX.equalTo(alertView.snp.centerX)
        }
        
        alertView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(alertView.snp.centerX)
        }
        
        alertView.addSubview(labelButtonDivider)
        labelButtonDivider.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(27)
            $0.leading.trailing.equalTo(alertView)
            $0.height.equalTo(Size.dividerWeight)
        }
        
        alertView.addSubview(buttonIntervalDivider)
        buttonIntervalDivider.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(27)
            $0.centerX.equalTo(alertView.snp.centerX)
            $0.width.equalTo(Size.dividerWeight)
            $0.height.equalTo(50)
        }
        
        alertView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(Size.buttonMinimumSize)
            $0.height.equalTo(Size.buttonMinimumSize)
            $0.top.equalTo(labelButtonDivider.snp.bottom).offset(3)
            $0.trailing.equalTo(buttonIntervalDivider.snp.leading).offset(-44)
        }
        
        alertView.addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(Size.buttonMinimumSize)
            $0.height.equalTo(Size.buttonMinimumSize)
            $0.top.equalTo(labelButtonDivider.snp.bottom).offset(3)
            $0.trailing.equalTo(buttonIntervalDivider.snp.trailing).offset(44)
        }
    }
    
    // MARK: - func
    
    private func setupAttribute() {
        titleLabel.text = title
        subTitleLabel.text = subTitle
        
        switch alertType {
        case .delete:
            actionButton.setTitle(alertType?.rawValue, for: .normal)
            actionButton.setTitleColor(.red100, for: .normal)
        case .join:
            actionButton.setTitle(alertType?.rawValue, for: .normal)
            actionButton.setTitleColor(.gray500, for: .normal)
            
        // FIXME: alertType이 전달되지 않을 경우
            
        case .none:
            actionButton.setTitle("확인", for: .normal)
            actionButton.setTitleColor(.gray500, for: .normal)
        }
    }
}
