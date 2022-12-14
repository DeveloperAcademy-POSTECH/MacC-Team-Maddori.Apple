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
            self?.dispatchCreateTeam(type: .dispatchCreateTeam(CreateTeamDTO(team_name: teamName)))
        }
        super.doneButton.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - func
    
    private func pushInvitationViewController(invitationCode: String) {
        if let teamName = super.kigoTextField.text {
            let viewController = InvitationCodeViewController(teamName: teamName, invitationCode: invitationCode)
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
                    if let invitationCode = json.detail?.invitationCode {
                        self.pushInvitationViewController(invitationCode: invitationCode)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.makeAlert(title: TextLiteral.createTeamViewControllerAlertTitle, message: TextLiteral.createTeamViewControllerAlertMessage)
                }
            }
        }
    }
}
