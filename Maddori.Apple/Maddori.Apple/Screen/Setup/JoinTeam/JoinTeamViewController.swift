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
    
    enum ViewType {
        case loginView
        case teamManageView
    }
    
    private var fromView: ViewType
    
    override var titleText: String {
        get {
            return TextLiteral.joinTeamViewControllerTitleLabel
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
        button.isHidden = fromView == .loginView ? false : true
        return button
    }()
    private lazy var createView: LabelButtonView = {
        let view = LabelButtonView()
        view.subText = TextLiteral.joinTeamViewControllerSubText
        view.subButtonText = TextLiteral.joinTeamViewControllerSubButtonText
        view.buttonAction = { [weak self] in
            self?.presentCreateTeamViewController()
        }
        view.isHidden = fromView == .loginView ? false : true
        return view
    }()
    private lazy var closeButton: CloseButton = {
        let button = CloseButton()
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        button.isHidden = fromView == .teamManageView ? false : true
        return button
    }()
    
    // MARK: - life cycle
    
    init(from: ViewType) {
        self.fromView = from
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDoneButton()
        setupKeyboard()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        doneButton.isLoading = false
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
        switch fromView {
        case .loginView:
            let button = removeBarButtonItemOffset(with: backButton, offsetX: 10)
            let backButton = makeBarButtonItem(with: button)
            
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationItem.largeTitleDisplayMode = .never
            navigationItem.leftBarButtonItem = backButton
        case .teamManageView:
            let button = removeBarButtonItemOffset(with: closeButton, offsetX: -10)
            let closeButton = makeBarButtonItem(with: button)
        
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationItem.largeTitleDisplayMode = .never
            navigationItem.rightBarButtonItem = closeButton
        }
    }
    
    // MARK: - setup
    
    private func setupDoneButton() {
        let action = UIAction { [weak self] _ in
            guard let invitationCode = self?.kigoTextField.text else { return }
            self?.doneButton.isLoading = true
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
    
    private func pushSetNicknameViewController() {
        let viewController = SetNicknameViewController(from: .joinView)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - api
    
    private func fetchCertainTeam(type: SetupEndPoint<EncodeDTO>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<TeamInfoResponse>.self) { json in
            if let json = json.value {
                dump(json)
                guard let teamId = json.detail?.id,
                      let teamName = json.detail?.teamName
                else { return }
                UserDefaultHandler.setTeamId(teamId: teamId)
                UserDefaultHandler.setTeamName(teamName: teamName)
                self.pushSetNicknameViewController()
            } else {
                DispatchQueue.main.async {
                    self.makeAlert(title: TextLiteral.joinTeamViewControllerAlertTitle, message: TextLiteral.joinTeamViewControllerAlertMessage)
                    self.doneButton.isLoading = false
                }
            }
        }
    }
}
