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
    
    var title: String {
        switch self {
        case .delete:
            return TextLiteral.feedbackFromMeDetailViewControllerAlertViewTitle
        case .join:
            return "합류 할 팀"
        }
    }
    
    var subTitle: String {
        switch self {
        case .delete:
            return TextLiteral.feedbackFromMeDetailViewControllerAlertViewSubTitle
        case .join:
            return "팀에 합류하시겠어요?"
        }
    }
    
    var actionTitle: String {
        switch self {
        case .delete:
            return "삭제"
        case .join:
            return "참여"
        }
    }
    
    var actionTitleColor: UIColor {
        switch self {
        case .delete:
            return .red100
        case .join:
            return .gray500
        }
    }
}

final class AlertViewController: BaseViewController {
    
    var type: AlertType
    var teamName: String? = nil
    
    init(type: AlertType) {
        super.init()
        self.type = type
    }
    
    init(type: AlertType, teamName: String?) {
        super.init()
        self.type = type
        self.teamName = teamName
    }
    
    required init?(coder: NSCoder) { nil }
    
    private enum Size {
        static let alertViewWidth: CGFloat = 265
        static let alertViewHeight: CGFloat = 163
        static let dividerWeight: CGFloat = 0.5
        static let buttonMinimumHeight: CGFloat = 44
    }
    
    // MARK: - property
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white100
        view.layer.cornerRadius = 10
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = type.title
        label.textColor = .blue200
        label.font = .main
        return label
    }()
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = type.subTitle
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
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLiteral.alertViewCancelButtonText, for: .normal)
        button.setTitleColor(.gray500, for: .normal)
        button.titleLabel?.font = .caption2
        button.titleLabel?.textAlignment = .center
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setTitle(type.actionTitle, for: .normal)
        button.setTitleColor(type.actionTitleColor, for: .normal)
        button.titleLabel?.font = .caption2
        button.titleLabel?.textAlignment = .center
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        view.backgroundColor = .black100.withAlphaComponent(0.85)
        setOkLabelColor()
        setTeamName()
    }
    
    override func render() {
        view.addSubview(alertView)
        alertView.snp.makeConstraints {
            $0.width.equalTo(Size.alertViewWidth)
            $0.height.equalTo(Size.alertViewHeight)
            $0.center.equalToSuperview()
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
            $0.bottom.equalTo(alertView.snp.bottom)
            $0.centerX.equalTo(alertView.snp.centerX)
            $0.width.equalTo(Size.dividerWeight)
        }
        
        alertView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.width.equalTo(Size.alertViewWidth / 2)
            $0.height.equalTo(Size.buttonMinimumHeight)
            $0.centerY.equalTo(buttonIntervalDivider.snp.centerY)
            $0.trailing.equalTo(buttonIntervalDivider.snp.leading)
        }
        
        alertView.addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.width.equalTo(Size.alertViewWidth / 2)
            $0.height.equalTo(Size.buttonMinimumHeight)
            $0.centerY.equalTo(buttonIntervalDivider.snp.centerY)
            $0.leading.equalTo(buttonIntervalDivider.snp.trailing)
        }
    }
    
    // MARK: - func
    
    private func setOkLabelColor() {
        if type == .join {
            actionButton.setTitleColor(type.actionTitleColor, for: .normal)
        }
    }
    
    private func setTeamName() {
        if type == .join {
            if teamName != nil {
                titleLabel.text = teamName
            }
        }
    }
}
