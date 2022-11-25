//
//  CreateTeamViewController.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/10/22.
//

import UIKit

import Alamofire
import SnapKit

final class CreateTeamViewController: BaseTextFieldViewController {
    
    override var titleText: String {
        get {
            return TextLiteral.createTeamViewControllerTitleLabel
        }
        
        set {
            super.titleText = newValue
        }
    }
    
    override var placeholderText: String {
        get {
            return TextLiteral.createTeamViewControllerTextFieldPlaceHolder
        }
        
        set {
            super.placeholderText = newValue
        }
    }
    
    override var buttonText: String {
        get {
            return TextLiteral.joinTeamViewControllerSubButtonText
        }
        
        set {
            super.buttonText = newValue
        }
    }
    
    override var maxLength: Int {
        get {
            return 10
        }
        
        set {
            super.maxLength = newValue
        }
    }
    
    // MARK: - property
    
    private lazy var closeButton: CloseButton = {
        let button = CloseButton()
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDoneButton()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let closeButton = makeBarButtonItem(with: closeButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = closeButton
    }
    
    // MARK: - setup
    
    private func setupDoneButton() {
        let action = UIAction { [weak self] _ in
            guard let teamName = self?.kigoTextField.text else { return }
            // FIXME: - header에는 user defaults에 있는 내 유저 id 값 넣기 -> 나중에는 로그인 토큰으로 변환 예정
            self?.dispatchCreateTeam(type: .dispatchCreateTeam(CreateTeamDTO(team_name: teamName)))
//            self?.dispatchUserLogin(type: .dispatchLogin(LoginDTO(username: UserDefaultStorage.nickname)))
        }
        super.doneButton.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - func
    
    private func pushInvitationViewController() {
        if let teamName = super.kigoTextField.text {
            let viewController = InvitationCodeViewController(teamName: teamName)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    // MARK: - api
    
    private func dispatchCreateTeam(type: SetupEndPoint<CreateTeamDTO>) {
        AF.request(type.address,
                   method: type.method,
                   parameters: type.body,
                   encoder: JSONParameterEncoder.default,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<CreateTeamResponse>.self) { json in
            if let json = json.value {
                dump(json)
                guard let teamId = json.detail?.id else { return }
                UserDefaultHandler.setTeamId(teamId: teamId)
                DispatchQueue.main.async {
                    self.pushInvitationViewController()
                }
            } else {
                DispatchQueue.main.async {
                    // FIXME: - UXWriting 필요
                    self.makeAlert(title: "에러", message: "중복된 팀 이름입니다")
                }
            }
        }
    }
    
//    private func dispatchUserLogin(type: SetupEndPoint<LoginDTO>) {
//        AF.request(type.address,
//                   method: type.method,
//                   parameters: type.body,
//                   encoder: JSONParameterEncoder.default
//        ).responseDecodable(of: BaseModel<MemberResponse>.self) { json in
//            if let json = json.value {
//                dump(json)
//                guard let userId = json.detail?.userId
//                else { return }
//                UserDefaultHandler.setUserId(userId : userId)
//                DispatchQueue.main.async {
//                    self.pushInvitationViewController()
//                }
//            } else {
//                DispatchQueue.main.async {
//                    // FIXME: - UXWriting 필요
//                    self.makeAlert(title: "에러", message: "중복된 닉네임입니다")
//                }
//            }
//        }
//    }
}
