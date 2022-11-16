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
    
    var name = "진저"
    
    override var titleText: String {
        get {
            return name + TextLiteral.joinTeamViewControllerTitleLabel
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
            // FIXME: - userId는 우선 UserDefaults로 변경. -> 이후엔 토큰으로 처리
            self?.dispatchJoinTeam(type: .joinTeam(JoinTeamDTO(invitation_code: invitationCode), userId: 18.description))
        }
        super.doneButton.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - func
    
    private func presentCreateTeamViewController() {
        let viewController = CreateTeamViewController()
        let rootViewController = UINavigationController(rootViewController: viewController)
        rootViewController.modalPresentationStyle = .fullScreen
        present(rootViewController, animated: true)
    }
    
    private func pushHomeViewController() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewCustomTabBarView()
    }
    
    // MARK: - api
    
    private func dispatchJoinTeam(type: SetupEndPoint<JoinTeamDTO>) {
        AF.request(type.address,
                   method: type.method,
                   parameters: type.body,
                   encoder: JSONParameterEncoder.default,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<JoinTeamResponse>.self) { json in
            if let json = json.value {
                dump(json)
                DispatchQueue.main.async {
                    self.pushHomeViewController()
                }
            } else {
                DispatchQueue.main.async {
                    // FIXME: - UXWriting 필요
                    self.makeAlert(title: "에러", message: "존재하지 않는 팀입니다.")
                }
            }
        }
    }
}
