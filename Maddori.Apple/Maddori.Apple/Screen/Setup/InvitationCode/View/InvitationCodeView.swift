//
//  InvitationCodeView.swift
//  Maddori.Apple
//
//  Created by 이성호 on 11/3/23.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class InvitationCodeView: UIView {
    
    // MARK: - property
    
    private var invitationCode: String = "" {
        didSet {
            self.updateInvitationCodeLabel()
        }
    }
    
    // MARK: - ui components
    
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
    private let copyCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(TextLiteral.invitationCodeViewControllerCopyCodeButtonText, for: .normal)
        button.setTitleColor(UIColor.blue200, for: .normal)
        button.titleLabel?.font = .label2
        button.backgroundColor = .gray100
        button.layer.cornerRadius = 7
        return button
    }()
    private let startButton: MainButton = {
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
    private let toastView = ToastView(type: .complete)
    
    var copyCodeButtonTapPublisher: Observable<Void> {
        return copyCodeButton.rx.tap.asObservable()
    }
    
    var startButtonTapPublisher: Observable<Void> {
        return startButton.rx.tap.asObservable()
    }
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private func
    
    private func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        addSubview(invitedCodeLabel)
        invitedCodeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        addSubview(copyCodeButton)
        copyCodeButton.snp.makeConstraints {
            $0.top.equalTo(invitedCodeLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(124)
            $0.height.equalTo(35)
        }
        
        addSubview(startButton)
        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(2)
        }
        
        addSubview(subLabel)
        subLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(startButton.snp.top)
            $0.height.equalTo(SizeLiteral.minimumTouchArea)
        }
    }
    
    private func copyCode() {
        UIPasteboard.general.string = self.invitationCode
    }

    // MARK: - public func
    
    func setupNavigationController(_ navigation: UINavigationController) {
        navigation.navigationBar.prefersLargeTitles = false
    }
    
    func setupNavigationItem(_ navigationItem: UINavigationItem) {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.hidesBackButton = true
    }
    
    func setupToastView(_ navigation: UINavigationController) {
        navigation.view.addSubview(toastView)
        toastView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(-60)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(46)
        }
    }
    
    func updateInvitationCode(code: String) {
        self.invitationCode = code
    }
    
    func updateInvitationCodeLabel() {
        self.invitedCodeLabel.text = self.invitationCode
    }
    
    func showToast(navigationController: UINavigationController) {
        toastView.showToast(navigationController: navigationController)
        copyCode()
    }
}
