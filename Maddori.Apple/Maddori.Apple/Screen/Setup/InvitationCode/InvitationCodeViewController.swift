//
//  InvitedCodeViewController.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/10/23.
//

import UIKit

import Alamofire
import SnapKit

final class InvitationCodeViewController: BaseViewController {
    
    let teamName: String
    
    init(teamName: String) {
        self.teamName = teamName
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - property
    private lazy var backButton: BackButton = {
        let button = BackButton()
        let action = UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: TextLiteral.invitationCodeViewControllerTitleLabel)
        return label
    }()
    private let invitedCodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(.bold, ofSize: 32)
        return label
    }()
    private lazy var copyCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(TextLiteral.invitationCodeViewControllerCopyCodeButtonText, for: .normal)
        button.setTitleColor(UIColor.blue200, for: .normal)
        button.titleLabel?.font = .label2
        button.backgroundColor = .gray100
        button.layer.cornerRadius = 4
        return button
    }()
    private lazy var startButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.invitationCodeViewControllerStartButtonText
        return button
    }()
    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.invitationCodeViewControllerSubLabelText
        label.font = .body2
        label.textColor = .gray400
        return label
    }()
    private let toastView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    private let toastContentView: ToastContentView = {
        let view = ToastContentView()
        view.toastType = .complete
        return view
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dispatchCreateTeam(type: .dispatchCreateTeam(CreateTeamDTO(team_name: teamName), userId: UserDefaultStorage.userID))
        setupCopyCodeButton()
        setupStartButton()
        setGradientToastView()
        render()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let button = removeBarButtonItemOffset(with: backButton, offsetX: 10)
        let backButton = makeBarButtonItem(with: button)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
    
    override func render() {
        
        navigationController?.view.addSubview(toastView)
        toastView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(-60)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(46)
        }

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(invitedCodeLabel)
        invitedCodeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(copyCodeButton)
        copyCodeButton.snp.makeConstraints {
            $0.top.equalTo(invitedCodeLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(124)
            $0.height.equalTo(35)
        }
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(2)
        }
        
        view.addSubview(subLabel)
        subLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(startButton.snp.top)
            $0.height.equalTo(SizeLiteral.minimumTouchArea)
        }
        
        toastView.addSubview(toastContentView)
        toastContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        toastContentView.render()
    }
    
    // MARK: - func
    
    private func showToastPopUp() {
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                self.toastView.transform = CGAffineTransform(translationX: 0, y: 115)
            }, completion: {_ in
                UIView.animate(withDuration: 1, delay: 0.8, animations: {
                    self.toastView.transform = .identity
                })
            })
    }
    
    private func setGradientToastView() {
        toastView.layoutIfNeeded()
        toastView.setGradient(colorTop: .gradientGrayTop, colorBottom: .gradientGrayBottom)
    }
    
    private func setupCopyCodeButton() {
        let action = UIAction { [weak self] _ in
            UIPasteboard.general.string = self?.invitedCodeLabel.text
            self?.showToastPopUp()
        }
        copyCodeButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupStartButton() {
        let action = UIAction { [weak self] _ in
            self?.pushHomeViewController()
        }
        startButton.addAction(action, for: .touchUpInside)
    }
    
    private func pushHomeViewController() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewCustomTabBarView()
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
                    self.invitedCodeLabel.text = json.detail?.invitationCode
                }
            } else {
                DispatchQueue.main.async {
                    // FIXME: - UXWriting 필요
                    self.makeAlert(title: "에러", message: "중복된 팀 이름입니다람쥐")
                }
            }
        }
    }
}