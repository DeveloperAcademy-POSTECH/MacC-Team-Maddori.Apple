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
    
    let invitationCode: String
    private var isTappedCopyButton: Bool = false
    
    init(invitationCode: String) {
        self.invitationCode = invitationCode
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: TextLiteral.invitationCodeViewControllerTitleLabel)
        return label
    }()
    private lazy var invitedCodeLabel: UILabel = {
        let label = UILabel()
        label.text = invitationCode
        label.font = UIFont.font(.bold, ofSize: 32)
        return label
    }()
    private lazy var copyCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(TextLiteral.invitationCodeViewControllerCopyCodeButtonText, for: .normal)
        button.setTitleColor(UIColor.blue200, for: .normal)
        button.titleLabel?.font = .label2
        button.backgroundColor = .gray100
        button.layer.cornerRadius = 7
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
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCopyCodeButton()
        setupStartButton()
        render()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.hidesBackButton = true
    }
    
    override func render() {
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
    }
    
    // MARK: - func
    
    private func setupCopyCodeButton() {
        let action = UIAction { [weak self] _ in
            self?.presentSharePanel()
        }
        copyCodeButton.addAction(action, for: .touchUpInside)
    }
    
    private func presentSharePanel() {
        let shareText: String = invitedCodeLabel.text ?? ""
        var shareObject = [Any]()
        shareObject.append(shareText)
        
        let activityViewController = UIActivityViewController(activityItems : shareObject, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToTwitter, UIActivity.ActivityType.mail]
        
        self.present(activityViewController, animated: true, completion: nil)
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
}
