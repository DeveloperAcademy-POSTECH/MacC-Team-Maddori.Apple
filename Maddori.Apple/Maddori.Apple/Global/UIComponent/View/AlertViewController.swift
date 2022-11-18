//
//  AlertView.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/11/06.
//

import UIKit

import Alamofire
import SnapKit

enum AlertType: String {
    case delete = "삭제"
    case join = "합류"
    
    var title: String {
        switch self {
        case .delete:
            return TextLiteral.alertViewControllerTypeDeleteTitle
        case .join:
            return TextLiteral.alertViewControllerTypeJoinTitle
        }
    }
    
    var subTitle: String {
        switch self {
        case .delete:
            return TextLiteral.alertViewControllerTypeDeleteSubTitle
        case .join:
            return TextLiteral.alertViewControllerTypeJoinSubTitle
        }
    }
    
    var actionTitle: String {
        switch self {
        case .delete:
            return self.rawValue
        case .join:
            return self.rawValue
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
    var navigation: UINavigationController? = nil
    
    init(type: AlertType, teamName: String?, navigation: UINavigationController?, teamId: Int? = nil) {
        self.type = type
        self.teamName = teamName
        self.navigation = navigation
        super.init()
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
        button.setTitle(TextLiteral.alertViewControllerCancelButtonText, for: .normal)
        button.setTitleColor(.gray500, for: .normal)
        button.titleLabel?.font = .body2
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
        button.titleLabel?.font = .body2
        button.titleLabel?.textAlignment = .center
        let action = UIAction { [weak self] _ in
            if let type = self?.type {
                self?.didTappedActionButton(type)
            }
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
            DispatchQueue.main.async {
                self.actionButton.setTitleColor(self.type.actionTitleColor, for: .normal)
            }
        }
    }
    
    private func setTeamName() {
        if type == .join {
            if teamName != nil {
                DispatchQueue.main.async {
                    self.titleLabel.text = self.teamName
                }
            }
        }
    }
    
    private func didTappedActionButton(_ type: AlertType) {
        switch type {
        case .delete:
            // FIXME: - 피드백 삭제 api 연결
            print("Delete")
        case .join:
            // FIXME: - 팀 합류 api 연결
            self.dispatchUserLogin(type: .dispatchLogin(LoginDTO(username: UserDefaultStorage.nickname)))
//            self.pushHomeViewController()
//            dispatchJoinTeam(type: .dispatchJoinTeam(teamId: UserDefaultStorage.teamId, userId: UserDefaultStorage.userId))
        }
        self.dismiss(animated: true) {
            self.navigation?.popViewController(animated: true)
        }
    }
    
    private func pushHomeViewController() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewCustomTabBarView()
    }
    
    // MARK: - api
    
    private func dispatchJoinTeam(type: SetupEndPoint<JoinTeamDTO>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<JoinTeamResponse>.self) { json in
            if let json = json.value {
                dump(json)
                DispatchQueue.main.async {
                    self.pushHomeViewController()
                }
            }
        }
    }
    
    private func deleteFeedBack(type: MyFeedBackEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<VoidModel>.self) { json in
            if let data = json.value {
                dump(data)
            }
        }
    }
    
    private func dispatchUserLogin(type: SetupEndPoint<LoginDTO>) {
        AF.request(type.address,
                   method: type.method,
                   parameters: type.body,
                   encoder: JSONParameterEncoder.default
        ).responseDecodable(of: BaseModel<MemberResponse>.self) { [weak self] json in
            if let json = json.value {
                dump(json)
                guard let userId = json.detail?.id
                else { return }
                UserDefaultHandler.setUserId(userId: userId)
                self?.dispatchJoinTeam(type: .dispatchJoinTeam(teamId: UserDefaultStorage.teamId))
            } else {
                DispatchQueue.main.async {
                    // FIXME: - UXWriting 필요
                    self?.makeAlert(title: "에러", message: "중복된 닉네임입니다람쥐")
                }
            }
        }
    }
}
