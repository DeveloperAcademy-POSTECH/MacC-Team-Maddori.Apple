//
//  JoinTeamViewController.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/10/20.
//

import UIKit

import Alamofire
import SnapKit

final class JoinTeamViewController: BaseTextFieldViewController {
    
    override var titleText: String {
        get {
            return UserDefaultStorage.nickname + TextLiteral.joinTeamViewControllerTitleLabel
        }
        
        set {
            super.titleText = newValue
        }
    }
    
    override var placeholderText: String {
        get {
            return TextLiteral.joinTeamViewControllerNicknameTextFieldPlaceHolder
        }
        
        set {
            super.placeholderText = newValue
        }
    }
    
    override var maxLength: Int {
        get {
            return 6
        }
        
        set {
            super.maxLength = newValue
        }
    }
    
    override var buttonText: String {
        get {
            return TextLiteral.doneButtonTitle
        }
        
        set {
            super.buttonText = newValue
        }
    }
    
    // MARK: - property
    
    private lazy var backButton: BackButton = {
        let button = BackButton()
        let action = UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var createView: LabelButtonView = {
        let view = LabelButtonView()
        view.subText = TextLiteral.joinTeamViewControllerSubText
        view.subButtonText = TextLiteral.joinTeamViewControllerSubButtonText
        view.buttonAction = { [weak self] in
            self?.presentCreateTeamViewController()
        }
        return view
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDoneButton()
        setupKeyboard()
    }
    
    override func render() {
        super.render()
        
        view.addSubview(createView)
        createView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(super.doneButton.snp.top)
            $0.height.equalTo(SizeLiteral.minimumTouchArea)
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let button = removeBarButtonItemOffset(with: backButton, offsetX: 10)
        let backButton = makeBarButtonItem(with: button)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - setup
    
    private func setupDoneButton() {
        let action = UIAction { [weak self] _ in
            guard let invitationCode = self?.kigoTextField.text else { return }
            self?.fetchCertainTeam(type: .fetchCertainTeam(invitationCode: invitationCode))
        }
        super.doneButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupKeyboard() {
        super.kigoTextField.keyboardType = .asciiCapable
        super.kigoTextField.autocapitalizationType = .allCharacters
    }
    
    // MARK: - func
    
    private func presentCreateTeamViewController() {
        let viewController = CreateTeamViewController()
        let rootViewController = UINavigationController(rootViewController: viewController)
        rootViewController.modalPresentationStyle = .fullScreen
        present(rootViewController, animated: true)
    }
        
    private func presentCertainTeamViewController(teamName: String, teamId: Int) {
        self.showAlertView(type: .join, teamName: teamName)
    }
    
    // MARK: - api
    
    private func fetchCertainTeam(type: SetupEndPoint<EncodeDTO>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<TeamInfoResponse>.self) { json in
            if let json = json.value {
                guard let teamId = json.detail?.id,
                      let teamName = json.detail?.teamName
                else { return }
                UserDefaultHandler.setTeamId(teamId: teamId)
                self.presentCertainTeamViewController(teamName: teamName, teamId: UserDefaultStorage.teamId)
            } else {
                DispatchQueue.main.async {
                    self.makeAlert(title: TextLiteral.joinTeamViewControllerAlertTitle, message: TextLiteral.joinTeamViewControllerAlertMessage)
                }
            }
        }
    }
}
