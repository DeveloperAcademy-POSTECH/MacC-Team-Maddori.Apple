//
//  LoginViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/06.
//

import AuthenticationServices
import UIKit

import SnapKit

final class LoginViewController: BaseViewController {
    
    // MARK: - property
    
    private let keygoLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.imgKeygoLogo
        return imageView
    }()
    private let keygoLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.loginViewControllerLogoText
        label.font = .font(.bold, ofSize: 25)
        return label
    }()
    private let keygoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.loginViewControllerDescriptionText
        label.font = .font(.bold, ofSize: 18)
        return label
    }()
    private lazy var appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        let action = UIAction { [weak self] _ in
            self?.appleSignIn()
        }
        button.cornerRadius = 15
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        super.configUI()
        setGradientText()
    }
    
    override func render() {
        view.addSubview(keygoLogoImage)
        keygoLogoImage.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(keygoLabel)
        keygoLabel.snp.makeConstraints {
            $0.top.equalTo(keygoLogoImage.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(keygoDescriptionLabel)
        keygoDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(keygoLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(appleLoginButton)
        appleLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.height.equalTo(54)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    // MARK: - func
    
    private func setGradientText() {
        keygoLabel.layoutIfNeeded()
        keygoLabel.setTextGradientColorTopToBottom(bound: keygoLabel.bounds)
        
        keygoDescriptionLabel.layoutIfNeeded()
        keygoDescriptionLabel.setTextGradientColorTopToBottom(bound: keygoDescriptionLabel.bounds)
    }
    
    private func appleSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

    // MARK: - extension

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userIdentifier = appleIDCredential.user
            
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    // The Apple ID credential is valid. Show Home UI Here
                    guard let token = appleIDCredential.identityToken else { return }
                    guard let tokenToString = String(data: token, encoding: .utf8) else { return }
                    print(tokenToString)
                    Task {
                        // API 코드 작성
                    }
                    break
                case .revoked:
                    // The Apple ID credential is revoked. Show SignIn UI Here.
                    break
                case .notFound:
                    // No credential was found. Show SignIn UI Here.
                    break
                default:
                    break
                }
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
